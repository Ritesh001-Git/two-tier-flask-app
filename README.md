 
# Flask App with MySQL Docker Setup

This is a simple Flask app that interacts with a MySQL database. The app allows users to submit messages, which are then stored in the database and displayed on the frontend.

## Prerequisites

Before you begin, make sure you have the following installed:

- Docker
- Git (optional, for cloning the repository)

## Setup

1. Clone this repository (if you haven't already):

   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   ```

2. Navigate to the project directory:

   ```bash
   cd your-repo-name
   ```

3. Create a `.env` file in the project directory to store your MySQL environment variables:

   ```bash
   touch .env
   ```

4. Open the `.env` file and add your MySQL configuration:

   ```
   MYSQL_HOST=mysql
   MYSQL_USER=your_username
   MYSQL_PASSWORD=your_password
   MYSQL_DB=your_database
   ```

## Usage

1. Start the containers using Docker Compose:

   ```bash
   docker-compose up --build
   ```

2. Access the Flask app in your web browser:

   - Frontend: http://localhost
   - Backend: http://localhost:5000

3. Create the `messages` table in your MySQL database:

   - Use a MySQL client or tool (e.g., phpMyAdmin) to execute the following SQL commands:
   
     ```sql
     CREATE TABLE messages (
         id INT AUTO_INCREMENT PRIMARY KEY,
         message TEXT
     );
     ```

4. Interact with the app:

   - Visit http://localhost to see the frontend. You can submit new messages using the form.
   - Visit http://localhost:5000/insert_sql to insert a message directly into the `messages` table via an SQL query.

## Cleaning Up

To stop and remove the Docker containers, press `Ctrl+C` in the terminal where the containers are running, or use the following command:

```bash
docker-compose down
```

## To run this two-tier application using  without docker-compose
- Clone the repo
```bash
git colne https://github.com/Ritesh001-Git/two-tier-flask-app
```

- Change the directory
```bash
cd two-tier-flask-app
```

- Create a docker image from Dockerfile
```bash
docker build -t two-tier-backend .
```

- Now, make sure that you have created a network using following command
```bash
docker network create two-tier -d bridge
```

- Attach both the containers in the same network, so that they can communicate with each other

i) MySQL container 
```bash
docker run -d --name mysql --network two-tier -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=devops mysql
```
ii) Backend container
```bash
docker run -d -p 5001:5000 --network two-tier -e MYSQL_HOST=mysql -e MYSQL_USER=root -e MYSQL_PASSWORD=root -e MYSQL_DB=devops two-tier-backend:latest
```
iii) Go to localhost 5001
```bash
localhost:5001
```
Send some message

- Go inside MySql Database
```bash
two-tier-flask-app % docker exec -it 6b27c4da6d08 bash

Replace with your container ID (from `docker ps`)

mysql -u root -p
use devops
select * from messages;

Review your messages.
```
## Notes

- Make sure to replace placeholders (e.g., `your_username`, `your_password`, `your_database`) with your actual MySQL configuration.

- This is a basic setup for demonstration purposes. In a production environment, you should follow best practices for security and performance.

- Be cautious when executing SQL queries directly. Validate and sanitize user inputs to prevent vulnerabilities like SQL injection.

- If you encounter issues, check Docker logs and error messages for troubleshooting.


## Mounting a Volume

- Create a volume
```bash
docker volume create mysql-data
```
- Inspect the volume
```bash
docker volume create mysql-data
```
- Stop the mysql Container
```bash
docker stop 6b27c4da6d08 && docker rm 6b27c4da6d08
```
- Mount the volume
```bash
docker run -d --name mysql --network two-tier -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=devops mysql
```
i) -v: Flag for volume.

ii) mysql-data: The name of our volume.

iii) /var/lib/mysql: Where MySQL stores its data inside the container.

- Restart the two-tier-aap Container
```bash
docker restart 67faa6ce6185
```
