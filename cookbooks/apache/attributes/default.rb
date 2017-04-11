default["apache"]["sites"]["chefnode"] = { "site_title" => "chefnode site comming soon", "port" => 80, "domain" => "chefnode.example.com"}
default["apache"]["sites"]["chefnode2"] = { "site_title" => "chefnode2 site comming soon", "port" => 80, "domain" => "chefnode2.example.com"}
default["apache"]["sites"]["ubuntunode"] = { "site_title" => "ubuntunode site comming soon", "port" => 80, "domain" => "ubuntunode.example.com"}

default["author"]["name"] = "QA Engineer"

case node["platform"] 
when "centos"
	default["apache"]["package"] = "httpd"
when "ubuntu"
	default["apache"]["package"] = "apache2"
end 
