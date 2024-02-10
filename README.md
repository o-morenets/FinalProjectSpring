#6.Система "Вступна кампанія" 

    Студент реєструється на оцінювання знань з дисциплін
    Адміністратор вносить оцінки з дисциплін, з яких складаються тести
    Студент обирає специальність в университеті
    Формуються рейтингові списки ти, хто пройшов тести. Студентам розсилаються повідомлення про результат тестування

Docker MySQL setup

docker pull mysql
docker run --name mysql-admission -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=admission -p 3306:3306 -d mysql:latest

1. copy the SQL file into the Docker container
   docker cp admission_create_tables.sql mysql-admission:/admission_create_tables.sql
   docker cp admission_fill_data.sql mysql-admission:/admission_fill_data.sql
2. Login to Docker
   docker ps
   docker exec -it mysql-admission /bin/bash
3. Login to MySQL
   mysql -u root -p
   show databases;
   use admission;
   show tables;
4. Run the SQL file
   source admission_create_tables.sql
   source admission_fill_data.sql
