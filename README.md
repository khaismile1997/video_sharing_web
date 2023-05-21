# Video Sharing Web Application

## Introduction
The Video Sharing Web Application is a platform where users can sharing video through youtube url, view, and interact with videos. It provides features such as user authentication, video sharing, liking/disliking videos, and more.

## Prerequisites
To run the Video Sharing Web Application, you need the following software and tools installed:

- Ruby (version 2.6.5)
- Ruby on Rails (version 6.0.2)
- MySQL (version 5.7)
- Docker Compose (version 2.17.3) - This is optional for Docker deployment

## Installation & Configuration
1. Clone the repository: `git clone https://github.com/khaismile1997/video_sharing_web.git`
2. Navigate to the project directory: `cd video_sharing_web`
3. Install dependencies: `bundle install`
4. Configure database settings:
   - Open the `config/database.yml` file and update the database configuration according to your MySQL setup.
5. Set up environment variables (if necessary):
   - Create a `.env` file in the project root directory and define any required environment variables.
   - Example: `DATABASE_USER=username`, `DATABASE_PASSWORD=password`

## Database Setup
1. Start mysql server:
   - Homebrew on macOS: brew services start mysql
   - Ubuntu: sudo service mysql start
2. Run database migrations: `rails db:migrate`

## Running the Application (without Docker)
1. Start the development server: `rails s`
2. Run migration: `rails db:migrate`
3. Change .env file:
   DATABASE_HOST=localhost
   DATABASE_USER=root
   DATABASE_PASSWORD=''
4. Access the web api in your web browser at: `http://localhost:3001`
5. Run the test suite: `rspec`

## Docker Deployment
1. Build the Docker image: `docker-compose build`
2. Run the Docker container: `docker-compose up`
3. Run migration: `docker-compose run web rake db:migrate`
4. Access the web api in your web browser at: `http://localhost:3001`
5. Run the test suite: `docker-compose run web rspec`

## Usage
- Register a new account or log in with your existing credentials.
- Share videos using the pop-up and input the youtube URL you wanted to.
- View and interact with videos shared by other users.
- Like or dislike videos to express your preference.
- You can watch more videos by clicking "View more" button.
- You will get a notification as soon as a user shares a new video

## Troubleshooting
If you encounter any issues during the setup or usage of the application, you can try the following solutions:

- Ensure that all dependencies and prerequisites are installed correctly.
- Double-check the database configuration in the `config/database.yml` file.
- Verify that the necessary environment variables are properly set.
  - GOOGLE_YOUTUBE_DATA_API_V3, GOOGLE_API_URL, YOUTUBE_BASE_URL
  - Database info variables
- Make sure the database server is running and accessible.
  - Docker: run `docker-compose ps`
  - Without docker:
    - Homebrew on macOS: run `brew services list`
    - Ubuntu: run `sudo service mysql status`
- Check the application logs for any error messages or exceptions.

If the problem persists, please [open an issue](https://github.com/khaismile1997/video_sharing_web/issues) on the project's GitHub repository for further assistance.

## Frontend Repository

The frontend of this project is developed using ReactJS and resides in a separate repository. You can find the frontend source code and related documentation in the [Video Sharing FE Web](https://github.com/khaismile1997/video_sharing_fe_web).
