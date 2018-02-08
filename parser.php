<?php
require 'simple_html_dom.php';
require 'sql.php';


//подключаем Builder
class Parser{
	private $_category;
	private $_pagination;
	private $_product;

	public function setCategory($data){
		$this->_category = $data;
	}

	public function setPagination($data){
		$this->_pagination = $data;
	}

	public function setProduct($data){
		$this->_product = $data;
	}

	public function curl_get($url = "", $referer = 'http://www.google.com') {
	 $headers = array("Accept-Language:ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7","Cache-Control: no-cache","Pragma: no-cache");
	  $ch = curl_init();
	  curl_setopt($ch, CURLOPT_URL, $url);
	  curl_setopt($ch, CURLOPT_HEADER, 0);
	  curl_setopt($ch, CURLOPT_HTTPHEADER,$headers);
	  curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.119 Safari/537.36");
	  curl_setopt($ch, CURLOPT_REFERER, $referer);
	  curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	  curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	  curl_setopt($ch, CURLOPT_COOKIEFILE, "cookiefile"); 
	  curl_setopt($ch, CURLOPT_COOKIEJAR, "cookiefile"); # SAME cookiefile
	  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); 
	  $data = curl_exec($ch);
	  curl_close($ch);
	  return $data;
	}

	//создаем категории в базе, если передан параметр(parent_id то это дочерняя и заносим тогда ее в кэш. Параметры: $name,$parent_id = false, $url = false
	public function setCategoryInfo($mas){

		$dat = [];
	 	foreach ($mas as $data){

	 	  //делаем проверку, что бы категория была с именем
		  if(!empty($data['name'])){

		    $category_group_id = 1;
		    $parent_id = (!empty($data['id'])) ? $data['id'] : 1;
		    $name = htmlentities($data['name']);
		    $nonDataStr = "";
		    $nonDataInt = 0;
		    $date_time = date("Y-m-d H:i:s");
		    $slug = $this->generate_chpu($data['name']);
		    $active = 1;
		    $url = (!empty($data['url'])) ? $data['url'] : false;
		    $parent_url = (!empty($data['parent_url'])) ? $data['parent_url'] : false;
 			
 			/*Заносим введеные данные в базу*/
		    $setCategory = DB::prepare("INSERT INTO category 
		                            (category_group_id, parent_id,name,title,h1,meta_description,breadcrumbs_label,slug,slug_compiled,slug_absolute,content,announce,sort_order,title_append,active,date_added,date_modified) 
		                              VALUES (:category_group_id, :parent_id, :name, :title, :h1, :meta_description, :breadcrumbs_label, :slug, :slug_compiled, :slug_absolute, :content, :announce, :sort_order, :title_append, :active, :date_added, :date_modified)");

		      $setCategory->bindParam(':category_group_id', $category_group_id);
		      $setCategory->bindParam(':parent_id', $parent_id);
		      $setCategory->bindParam(':name',$name);
		      $setCategory->bindParam(':title', $name);
		      $setCategory->bindParam(':h1', $name);
		      $setCategory->bindParam(':meta_description', $nonDataStr);
		      $setCategory->bindParam(':breadcrumbs_label', $name);
		      $setCategory->bindParam(':slug', $slug);
		      $setCategory->bindParam(':slug_compiled', $nonDataStr);
		      $setCategory->bindParam(':slug_absolute', $nonDataInt);
		      $setCategory->bindParam(':content', $nonDataStr);
		      $setCategory->bindParam(':announce', $nonDataStr);
		      $setCategory->bindParam(':sort_order', $nonDataInt);
		      $setCategory->bindParam(':title_append', $nonDataStr);
		      $setCategory->bindParam(':active', $active);
		      $setCategory->bindParam(':date_added', $date_time);
		      $setCategory->bindParam(':date_modified', $date_time);
		 	  $setCategory->execute();
		      
		      //возвращаем id добавленной категории
		      $lastID = DB::lastInsertId();
		 
		 		//делаем проверку, получаем ли ссылку на дочернюю категорию, если все гуд то создаем кэш по дочерним категориям
		      	if(!empty($url)){
		      		$setCacheCategory = DB::prepare("INSERT INTO cache_category 
		                           (parent_id,category_id,url) VALUES
		                            (:parent_id, :category_id, :url)");

				    $setCacheCategory->bindParam(':parent_id', $parent_id);
				    $setCacheCategory->bindParam(':category_id', $lastID);
				    $setCacheCategory->bindParam(':url', $url);
		  			$setCacheCategory->execute();
		      	}

		      	$dat [] = [
		      		'id' 	=> $lastID,
		      		'parent_url'	=> $parent_url,			
		      	];
		  	}

	 	}

 		return $dat;
 	}

 	//заносим в базу ссылки на пагинацию
 	public function setPaginationUrl($parent_id,$category_id,$url){

 		if(!empty($parent_id) && !empty($category_id) && !empty($url)){
	 		/*Заносим введеные данные в базу*/
			$setPagination = DB::prepare("INSERT INTO cache_pagination 
			                            (parent_id,category_id, url) 
			                              VALUES (:parent_id, :category_id, :url)");
			$setPagination->bindParam(':parent_id', $parent_id);
			$setPagination->bindParam(':category_id', $category_id);
			$setPagination->bindParam(':url', $url);
			$setPagination->execute();
		}
 	}

 	//подготовленные данные заносим в кэш продутка
 	public function setCacheHtmlProducts($data){

 		if(!empty($data)){
 			foreach($data as $dat){
 				$setCacheHtml = DB::prepare("INSERT INTO cache_products 
	                            (parent_id,category_id, name, html) 
	                              VALUES (:parent_id, :category_id, :name, :html)");
			 	$setCacheHtml->bindParam(':parent_id', $dat['parent_id']);
			 	$setCacheHtml->bindParam(':category_id', $dat['category_id']);
			    $setCacheHtml->bindParam(':name', $dat['name']);
			    $setCacheHtml->bindParam(':html', $dat['html']);
			    $setCacheHtml->execute();
 			}
 		}

 		return true;
 			
 	}

 	//функция по созданию продукта в базе
 	public function createProduct($mas){

 		if(!empty($mas)){
 			$parent_id = 0;
 			$zero = 0;
 			$empt = "";
 			$active = 1;
 			$one = 1;
 			$option_generate = "";

 			foreach($mas as $data){
 				$category_id = (!empty($data['category_id'])) ? $data['category_id'] : 1;
 				$parent_category_id = (!empty($data['parent_category_id'])) ? $data['parent_category_id'] : "";
 				$name = (!empty($data['name'])) ? htmlentities($data['name']) : "";
 				$desc = (!empty($data['desc'])) ? $data['desc'] : "";
 				$charact = (!empty($data['charact'])) ? $data['charact'] : "";
 				$price = (!empty($data['price'])) ? $data['price'] : 0;
 				$date_time = date("Y-m-d H:i:s");
 				$sku = (!empty($data['sku'])) ? $data['sku'] : "";
 				$images = (!empty($data['image'])) ? $data['image'] : "";

 				//делаем проверку если символов больше 70 то обрезаем (в базе можно хранить до 80)
 				$count_slug_symbol = mb_strlen($name);
 				if($count_slug_symbol >= 70){
   					$name_count_symbol = substr($name, 0,70);
 					$slug = $this->generate_chpu($name_count_symbol);

 				}else{
 					$slug = $this->generate_chpu($name);
 				}

 				 
 
 				//заносим данные в таблицу product
 				$setCreateProduct = DB::prepare("INSERT INTO product 
 					(main_category_id,parent_id,option_generate,name,title,h1,meta_description,breadcrumbs_label,slug,slug_compiled,slug_absolute,content,announce,sort_order,active,price,old_price,sku,unlimited_count,currency_id,measure_id,date_added,date_modified) 

			                              VALUES (:main_category_id,:parent_id,:option_generate, :name,:title, :h1,:meta_description,:breadcrumbs_label,:slug, :slug_compiled, :slug_absolute,:content,:announce,:sort_order, :active,:price,:old_price,:sku,:unlimited_count,:currency_id,:measure_id,:date_added,:date_modified)");
				$setCreateProduct->bindParam(':main_category_id', $category_id);
				$setCreateProduct->bindParam(':parent_id', $parent_id);
				$setCreateProduct->bindParam(':option_generate', $option_generate);
				$setCreateProduct->bindParam(':name', $name);
				$setCreateProduct->bindParam(':h1', $name);
 				$setCreateProduct->bindParam(':title', $name);
				$setCreateProduct->bindParam(':meta_description', $name);
				$setCreateProduct->bindParam(':breadcrumbs_label', $name);
				$setCreateProduct->bindParam(':slug', $slug);
				$setCreateProduct->bindParam(':slug_compiled', $empt);
				$setCreateProduct->bindParam(':slug_absolute', $zero);
				$setCreateProduct->bindParam(':content', $charact);
				$setCreateProduct->bindParam(':announce', $desc);
				$setCreateProduct->bindParam(':sort_order', $zero);
				$setCreateProduct->bindParam(':active', $active);
				$setCreateProduct->bindParam(':price', $price);
				$setCreateProduct->bindParam(':old_price', $zero);
				$setCreateProduct->bindParam(':sku', $sku);
				$setCreateProduct->bindParam(':unlimited_count', $one);
				$setCreateProduct->bindParam(':currency_id', $one);
				$setCreateProduct->bindParam(':measure_id', $one);
				$setCreateProduct->bindParam(':date_added', $date_time);
				$setCreateProduct->bindParam(':date_modified', $date_time);
 				$setCreateProduct->execute();

				//возвращаем id добавленого товара
		      	$lastID = DB::lastInsertId();


		      	//если товар на сайте добавлен в родительскую категорию то и значит добавляем так же
		      	if(!empty($parent_category_id)){
		      		$setParentCategory = DB::prepare("INSERT INTO product_category 
	                            (category_id,object_model_id,sort_order) 
	                              VALUES (:category_id, :object_model_id, :sort_order)");
				 	$setParentCategory->bindParam(':category_id', $parent_category_id);
				 	$setParentCategory->bindParam(':object_model_id', $lastID);
				    $setParentCategory->bindParam(':sort_order', $zero);
 				    $setParentCategory->execute();
		      	}

		      		$setParentCategory1 = DB::prepare("INSERT INTO product_category 
	                            (category_id,object_model_id,sort_order) 
	                              VALUES (:category_id, :object_model_id, :sort_order)");
				 	$setParentCategory1->bindParam(':category_id', $category_id);
				 	$setParentCategory1->bindParam(':object_model_id', $lastID);
				    $setParentCategory1->bindParam(':sort_order', $zero);
 				    $setParentCategory1->execute();

 
 				    //если есть данные о картинках в товаре то заносим эту инфу в базу
 				    if(!empty($images)){
			 			$object_id = 3; //table object id 3 Product
			 			foreach($images as $image){
 			 				$filename = $this->setImageName("https://bikeland.ru",$image->href);
 							
 							$setImage = DB::prepare("INSERT INTO image 
				                            (object_id,object_model_id,filename,image_title,sort_order,image_alt) 
				                              VALUES (:object_id, :object_model_id,:filename,:image_title, :sort_order,:image_alt)");
							$setImage->bindParam(':object_id', $object_id);
							$setImage->bindParam(':object_model_id', $lastID);
							$setImage->bindParam(':filename', $filename);
							$setImage->bindParam(':image_title', $filename);
							$setImage->bindParam(':sort_order', $zero);
							$setImage->bindParam(':image_alt', $filename);
			 				$setImage->execute();	
		 				}
 					}
 				}
 			}
 		}

				

	//генерирует ЧПУ
	public function generate_chpu($str){
		if(!empty($str)){
 			$converter = array(
		          'а' => 'a',   'б' => 'b',   'в' => 'v',
		          'г' => 'g',   'д' => 'd',   'е' => 'e',
		          'ё' => 'e',   'ж' => 'zh',  'з' => 'z',
		          'и' => 'i',   'й' => 'y',   'к' => 'k',
		          'л' => 'l',   'м' => 'm',   'н' => 'n',
		          'о' => 'o',   'п' => 'p',   'р' => 'r',
		          'с' => 's',   'т' => 't',   'у' => 'u',
		          'ф' => 'f',   'х' => 'h',   'ц' => 'c',
		          'ч' => 'ch',  'ш' => 'sh',  'щ' => 'sch',
		          'ь' => '',    'ы' => 'y',   'ъ' => '',
		          'э' => 'e',   'ю' => 'yu',  'я' => 'ya',
		 
		          'А' => 'A',   'Б' => 'B',   'В' => 'V',
		          'Г' => 'G',   'Д' => 'D',   'Е' => 'E',
		          'Ё' => 'E',   'Ж' => 'Zh',  'З' => 'Z',
		          'И' => 'I',   'Й' => 'Y',   'К' => 'K',
		          'Л' => 'L',   'М' => 'M',   'Н' => 'N',
		          'О' => 'O',   'П' => 'P',   'Р' => 'R',
		          'С' => 'S',   'Т' => 'T',   'У' => 'U',
		          'Ф' => 'F',   'Х' => 'H',   'Ц' => 'C',
		          'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Sch',
		          'Ь' => '',    'Ы' => 'Y',   'Ъ' => '',
		          'Э' => 'E',   'Ю' => 'Yu',  'Я' => 'Ya',
		    );
		    $str = strtr($str, $converter);
		    $str = strtolower($str);
		    $str = preg_replace('~[^-a-z0-9_]+~u', '-', $str);
		    $str = trim($str, "-");
		    return $str;
	    }

    }

    //передаем ссылки и получаем взамен имя картинки и ее расширение
    public function setImageName($home="",$url){

    	if(!empty($url)){
    		$path_parts = pathinfo($home.$url);
  	  		return htmlentities($path_parts['filename']).".".$path_parts['extension'];
    	}else{
    		return false;
    	}
    }


    //функция по скачиванию картинок
    public function downloadImage($mas){
    	if(!empty($mas)){
    		$data_image = [];

	    	$ch = curl_init();
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);  
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  			curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
			curl_setopt($ch, CURLOPT_HEADER, 0);

			foreach($mas as $image){
				curl_setopt($ch, CURLOPT_URL,$image['url']);
				$response = curl_exec($ch);
				//проверяем нету ли ошибок на стороне сервера, если нету то загружаем картинку
				if(!empty($response)){
					$data_image[] = [
					'name_image'    => 'images/'.$image['name'],
					'response'      =>  $response,
					];
				} 
			}
			curl_close($ch);
			//запускаем цикл по скачиванию картинок
			foreach($data_image as $img){
				file_put_contents($img['name_image'], $img['response']); 
			}
		}						
 	}


    //удаляем кэш
	public function clearCache(){
 		$clearCache_category = "DELETE FROM  cache_category";
	 	DB::run($clearCache_category);
	 		 
	   	$clearCache_pagination = "DELETE FROM cache_pagination";
	 	DB::run($clearCache_pagination);

	 	$clearCache_products = "DELETE FROM cache_products";
	 	DB::run($clearCache_products);
  	}
 
}


abstract class BuilderParser{
	protected $_parser;

	public function getParserData(){
		return $this->_parser;
	}

	public function createParser(){
		  $this->_parser = new Parser;
	}

 	abstract public function buildCategory();
	abstract public function buildPagination();
	abstract public function buildProduct();
}

class BuilderBikeland extends BuilderParser{
	//временное хранилище
	public $cache = [];

	//главная страница
	public $home = "https://bikeland.ru";

	//Наследуем абстрактный  метод по созданию категорий
	public function buildCategory(){
		echo "Category Start!"."\n";

		//получаем родиельские категории на главной странице
		//$this->getParentsCategoryBikeland();

		//добавляем дочерние категории в базу
		//$this->setDaughterCategoryBikeland();

		//получаем дочерние категории для создания пагинации
		//$this->getDaughterCategoryBikeland();

		 
		return true;
 	}

 	//Наследуем абстрактный  метод по созданию ссылок пагинации
 	public function buildPagination(){
 		echo "Pagination Start!"."\n";
 		 
 		//создаем ссылки на пагинации в дочерних категориях
 		//$this->setPaginationInfo();
 		 

 		return true;
 	}

 	//Наследуем абстрактный  метод по созданию товара
 	public function buildProduct(){

 		echo "Product Start!"."\n";

 		//по ссылкам с пагинации заносим html и название товара в базу
		//$this->getInfoCacheProducts();
 	
 		//получаем данные с базы, парсим и заносим всю инфу для создания товара
 		//$this->setProductInfo();
 		
 		return true;
 	}
 
	//добавляем родительские категории в базу
	public function getParentsCategoryBikeland(){
	  //Выводим сообщение в консоль		
	  echo "Get Index Page and set parents category!"."\n";

 	  $html = str_get_html($this->_parser->curl_get($this->home));
	  $data = [];
	 
	  if($html->innertext!='' and !empty($html->find('.catalogfirst a.icons_fa'))){
	    foreach($html->find('.catalogfirst a.icons_fa') as $a){
	    	$data[] = [
	    		'name'			=>	$a->plaintext,
	    		'parent_url'	=>	$this->home.$a->href,
 	    	];
 		}
	  }
 	  
 	  //подчищаем за собой
	  $html->clear();
	  unset($html);

	  //заносим в базу название родительской категории
	  $parents_id = $this->_parser->setCategoryInfo($data);

 	  return $this->cache = $parents_id;
 	}


	//заносим в базу дочерние категории $parents_id, $parent_url
	public function setDaughterCategoryBikeland(){

 	  //Выводим сообщение в консоль		
	  echo "Set Daughter Category!"."\n";

	  $mas = $this->cache;
 	  unset($this->cache);

 	  $dat = [];
 	  $cache_productsInfo = [];
 	  foreach($mas as $data){
 	  	if(!empty($data['id'])){
 				$html = str_get_html($this->_parser->curl_get($data['parent_url']));
 				//проверяем существует ли дочерние категории на странице
		        if($html->innertext!='' and !empty($html->find('.catalog_section_list .section_info li.name a'))){
				    foreach($html->find('.catalog_section_list .section_info li.name a') as $a){
				         $dat[] = [
				         	'id'		=>	$data['id'],
				         	'name'		=>	htmlentities($a->plaintext),
				         	'url'		=>	$this->home.$a->href,

				         ];

				         echo $this->home.$a->href."\n";
 					}
 
		 		}elseif($html->innertext!='' and !empty($html->find('.item-title a'))){
		 			foreach($html->find('.item-title a') as $a){
		 				$cache_productsInfo[] = [
						'name'			=> htmlentities($a->plaintext),
						'html'			=> $this->_parser->curl_get($this->home.$a->href),
						'parent_id' 	=> 1,
				  		'category_id' 	=> $data['id'],
						];
		 			}
 			 	}
		  	
			}
	  	}

	  	$html->clear();
		unset($html);

	  	if(!empty($dat)){
	  		$this->_parser->setCategoryInfo($dat);
	  	}

	  	if(!empty($cache_productsInfo)){
	  		$this->_parser->setCacheHtmlProducts($cache_productsInfo);
 	  	} 

 	  	return true;
		
 
 	}

 	//проверяем существуют ли категории в дочерних категориях
	public function getDaughterCategoryBikeland(){

		echo "Get Daughter Category (replay search category)!"."\n";

		//с базы получаем данные id родительской категории и ссылку на дочерню категорию
		$stmt = 'SELECT category_id,url FROM cache_category';

		$stmt = DB::run($stmt);

		//в этот массив заносим category_id,url
 		$dauth = [];

		foreach($stmt as $data){
		 
			//заносим в переменную инфу о том есть ли дочерние категории в текущей категории
			$dauth[] = [
 				'id'			=>	$data['category_id'],
				'parent_url'	=>	$data['url'],
			];

			echo $data['url']."\n";
 		}

 		//данные которые получили с базы отправляем повторно для того что бы опеределить если ли еще дочерние категории
 		$this->cache = $dauth;
 		$this->setDaughterCategoryBikeland();

  		return true;
	}

	//в базу заносим ссылки на список товара категории (ссылки пагинации) 
	public function setPaginationInfo(){

		echo "Set Pagination!"."\n";

		//с базы получаем данные id родительской категории и ссылку на дочерню категорию
		$stmt = 'SELECT parent_id,category_id,url FROM cache_category';

		$stmt = DB::run($stmt);
 
 		foreach($stmt as $data){
 
 			//делаем проверку данных, что бы не были пустыми
			if(!empty($data['url'])){

				//выводим ссылки в консоль
				 echo $data['url']."\n";

				$html = str_get_html($this->_parser->curl_get($data['url']));
	 			$prev = $html->find('.flex-nav-prev  a');
	 			$countNumberPage = count($html->find('.nums  a'));
	 			$numberPage = $html->find('.nums  a');
	  
	 			//сколько страниц в пагинации скольки итераций сделает цикл 
				switch($countNumberPage){
				 
				    case 2:
				        $countPages = $numberPage[1]->plaintext;
				        break;
				    case 3:
				        $countPages = $numberPage[2]->plaintext;
				        break;

				    case 4:
				        $countPages = $numberPage[3]->plaintext;
				        break;  
				}

				$html->clear();
		  		unset($html);


	 			//начиная с первой страницы заносим ее в базу
				if(empty($prev)){
					/*Заносим введеные данные в базу*/
					$this->_parser->setPaginationUrl($data['parent_id'],$data['category_id'],$data['url']);
		 		}

				//если находим ссылку в пагинации на слудющую страницу то заносим ее в базу
				if(!empty($countPages)){

					for($i = 2; $i<=$countPages; $i++){
						/*Заносим введеные данные в базу*/
						$this->_parser->setPaginationUrl($data['parent_id'],$data['category_id'],$data['url']."?PAGEN_1=".$i);
					}

				}
	 		}
 		}

 		return true;
	}
 

	//получаем с базы всю нужную информацию для создания кэша продутка
	public function getInfoCacheProducts(){

		echo "Get Info Cache products!"."\n";
 

			//с базы получаем данные id родительской категории, id дочерний категори, url
			$stmt = "SELECT id,parent_id,category_id,url FROM cache_pagination";

			$stmt = DB::run($stmt);
			$cache_productsInfo = [];
 

			//формируем массив для получения ссылки на каждый товар
			foreach($stmt as $d){
 					$html = str_get_html($this->_parser->curl_get($d['url']));
					if($html->innertext!='' and !empty($html->find('.item-title a'))){
					    foreach($html->find('.item-title a') as $a){
					    	$cache_productsInfo[] = [
					    		'name'			=> htmlentities($a->plaintext),
					    		'html'			=> $this->_parser->curl_get($this->home.$a->href),
					    		'parent_id' 	=> $d['parent_id'],
			  					'category_id' 	=> $d['category_id'],
					    	];

					    	echo $d['id']."||".htmlentities($a->plaintext)."\n";
 						}
 					}
			}
		  	
			    $html->clear();
			  	unset($html);

			  	
		 
			  	//проверяем создался ли массив
			  	if(!empty($cache_productsInfo)){
			  		 $this->_parser->setCacheHtmlProducts($cache_productsInfo);
  				}	

  				return true;  	 
		 		
		 	} 
 
    //функция которая получает с базы кэш продукта парсит его и отправляет на добавление в базу товара
    public function setProductInfo(){
    			
    echo "Set Product Info!"."\n";

    #TODO и еще нужно разобраться со всяким бредом типа размер, цвет и все подобное 
 
 		//с базы получаем данные для парсинга и добавление товара в базу
		//$stmt = "SELECT id,parent_id,category_id,name,html FROM cache_products";
    	$stmt = "SELECT id,parent_id,category_id,name,html FROM cache_products LIMIT 2420";
 		$stmt = DB::run($stmt);	
 		
 		//формируем массив данных с базы
 		$mas = [];
 		foreach($stmt as $data){
 			$mas[] = [
 				"parent_category_id"	=>	$data['parent_id'],
 				"category_id"			=>	$data['category_id'],
 				"name"					=>	$data['name'],
 				"html"					=>	$data['html'],
 				"id"					=>	$data['id'],

 			];
 		}

 		//формируем массив для создания товара
 		$products = [];
 		$images = [];
  		foreach($mas as $data){
 			$html = str_get_html($data['html']);
 			$price = (!empty($html->find('.price span.price_value'))) ? 
 						trim($html->find('.price span.price_value')[0]->plaintext) : 0;
 			$article = (!empty($html->find('.article span.value'))) ? 
 						trim($html->find('.article span.value',0)->plaintext) : "";

 			$desc = (!empty($html->find('.tabs-body .detail_text'))) ? 
 						trim($html->find('.tabs-body .detail_text')[0]->plaintext) : "";

 			$characts = (!empty($html->find('.tabs_content .props_list',0))) ? 
 						trim($html->find('.tabs_content .props_list',0)->innertext) : "";

 			$charact = "<table><tbody>".$characts."</table></tbody>";
 			$filename = (!empty($html->find('.item_slider ul.slides a'))) ? $html->find('.item_slider ul.slides a') : "";												

 			$products[] = [
 			"parent_category_id"	=>	$data['parent_category_id'],
 			"category_id"			=>	$data['category_id'],
 			"name"					=>	trim($data['name']),
 			"price"					=>  str_replace(" ","",$price),
 			"sku"					=>	$article,
 			"desc"					=>	$desc,
 			"charact"				=>	(!empty($characts)) ? $charact : "",
 			"image"					=>	$filename,
 			];

 			//получаем ссылку на картинку(для загрузки) и имя картинки
 			if(!empty($filename)){
 				foreach ($filename as $a){
	 				$images[] = [
	 				"name" 	=> $this->_parser->setImageName($this->home,$a->href),
	 				"url" 	=> $this->home.$a->href,
	 				];
 				}

 			}

 			echo $data['id']."||".trim($data['name'])."\n";

 		}

 		$html->clear();
		unset($html);

 		//создаем товар
 		$this->_parser->createProduct($products);
 

 		//скачиваем картинки
		$this->_parser->downloadImage($images);

		return true;

   	} 
		
    



    

    


 
 










/*END CLASS*/
}

/*
class BuilderDrivebike extends BuilderParser{

	
}
*/

class Chooser{
  	private $_builderParser;
 
    public function setBuilderParser(BuilderParser $mp){
         $this->_builderParser = $mp;
    }
 
    public function getParserData(){
         return $this->_builderParser->getParserData();
    }
 
    public function constructParser(){
         $this->_builderParser->createParser();
         $this->_builderParser->buildCategory();
         $this->_builderParser->buildPagination();
         $this->_builderParser->buildProduct();
  	}
}

#TODO сделать так то бы перед запуском  парсера нового сайта, после старого парсинга делалась очистка кэша, что бы база была готовая (чистая) перед новым сайтом для парсинга

$start = new Chooser();
$bikeland = new BuilderBikeland();
//$drivebike = new BuilderDrivebike();
$start->setBuilderParser($bikeland);
$start->constructParser();
$realPhone = $start->getParserData();