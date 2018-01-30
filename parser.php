<?php
require 'simple_html_dom.php';
require 'sql.php';

#TODO в результате по идее должно выйти все в один итог это занести данные в базу дотплант

#TODO проверить еще раз вроде с категориями все, нужно дальше добивать пагинацию, но это не точно, нужно еще раз сверить все ли по категориям сделано




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
	  $ch = curl_init();
	  curl_setopt($ch, CURLOPT_URL, $url);
	  curl_setopt($ch, CURLOPT_HEADER, 0);
	  curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; WOW64; ry: 38.0) Gecko/20100101 Firefox/38.0");
	  curl_setopt($ch, CURLOPT_REFERER, $referer);
	  curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	  curl_setopt ($ch, CURLOPT_RETURNTRANSFER, TRUE);
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
		    $parent_id = (!empty($data['parent_id'])) ? $data['parent_id'] : 1;
		    $name = htmlentities($data['name']);
		    $nonDataStr = "";
		    $nonDataInt = 0;
		    $date_time = date("Y-m-d H:i:s");
		    $slug = $this->generate_chpu($data['name']);
		    $active = 1;
		    $url = (!empty($data['url'])) ? $data['url'] : false;
 			
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
		      		'parent_id' 	=> $lastID,
		      		'url'			=>	$url,			
		      	];
		  	}

	 	}

 		return $dat;
 	}

	//генерирует ЧПУ
	public function generate_chpu($str){
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

	public function buildCategory(){

		//получаем родиельские категории на главной странице
		$this->getParentsCategoryBikeland();

		//добавляем дочерние категории в базу
		$this->setDaughterCategoryBikeland();

	}

	//добавляем родительские категории в базу
	public function getParentsCategoryBikeland(){
 	  $html = str_get_html($this->_parser->curl_get($this->home));
	  $data = [];
	 
	  if($html->innertext!='' and count($html->find('.catalogfirst a.icons_fa'))){
	    foreach($html->find('.catalogfirst a.icons_fa') as $a){
	    	$data[] = [
	    		'name'	=>	$a->plaintext,
	    		'url'	=>	$this->home.$a->href,
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


	//заносим в базу дочерние категории $parents_id, $url
	public function setDaughterCategoryBikeland(){
 		
 	  $mas = $this->cache;
 	  unset($this->cache);

 	  $dat = [];
 	  foreach($mas as $data){
 	  	$html = str_get_html($this->_parser->curl_get($data['url']));

 			if(!empty($data['parent_id'])){
 				//проверяем существует ли дочерние категории на странице
		        if($html->innertext!='' and count($html->find('.catalog_section_list .section_info li.name a'))){
				    foreach($html->find('.catalog_section_list .section_info li.name a') as $a){
				         $dat[] = [
				         	'parent_id'	=>	$data['parent_id'],
				         	'name'		=>	$a->plaintext,
				         	'url'		=>	$this->home.$a->href,

				         ];
				    }

			      	//подчищаем за собой
				  	$html->clear();
				  	unset($html);
		 		}
 			}
	  	}

	  	$setDaughterCategory = (!empty($dat)) ? $dat : false;

	  	//заносим дочерние категории в базу
	  	return $this->_parser->setCategoryInfo($setDaughterCategory);
 	}

	

	







/*END CLASS*/
}


class BuilderDrivebike extends BuilderParser{

	
}

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
