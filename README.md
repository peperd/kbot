## Project README

### Overview
This project is written in Go and utilizes the following frameworks:
- [cobra](https://github.com/spf13/cobra)
- [telebot.v3](https://gopkg.in/telebot.v3)

The goal of the project is to implement message handlers for a Telegram bot, which will respond to messages in a Telegram chat.

### Features
- Implement message handlers for the bot to respond to Telegram messages.
- Create message handling functions.
- Add these functions to the methods of the `telebot.Bot` object.
- Handle messages according to their type and content.

### Requirements
- Go programming language installed on your system.
- Access to a Telegram Bot API token.
- Basic understanding of Go programming.

### Installation
1. Clone the repository:
   ```bash
   git clone git@github.com:peperd/kbot.git

2. Navigate to the project directory:
    ``` bash
    cd <project_directory>

3. Install dependencies:
    ``` bash
    go mod tidy

4. Configuration
Obtain a Telegram Bot API token from the BotFather.
Create a .env file in the project root directory.
Add your Telegram Bot API token to the .env file:
makefile
5. Export TELE_TOKEN
    ``` bash
    export TELE_TOKEN
    
### Usage

1. To build the application for Linux by default, simply run:

   ```bash
   make build
   ```

   You can also specify the target operating system and architecture using the following commands:

   - For Windows with AMD64 architecture:
   
     ```bash
     make build_windows
     ```

   - For macOS with AMD64 architecture:
   
     ```bash
     make build_macOS
     ```

   - For macOS with ARM architecture:
   
     ```bash
     make build_macOSARM
     ```
2. Once the application is built, you can run it using:
    ``` bash
    ./kbot.git start      

3. To push the Docker image to Google Container Registry (GCR), use:
    ``` bash
    make push


4. Type in bot in your Telegram chat 
    ``` bash
    /start hello

## Contributing
Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.

## License
This project is licensed under the MIT License.
