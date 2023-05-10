#include <iostream>
#include <unistd.h>
#include <csignal>
#include <sys/types.h>
#include <sys/wait.h>

int counter = 0;

void signalHandler(int signum)
{
    auto c_pid = fork();
    if (c_pid)
    {
        wait(NULL);
        std::cout << "Interrupt signal (" << signum << ") received" << std::endl;
        std::cout << "Terminated, counter: " + std::to_string(++counter) + " "
                  << "Exit" << std::endl;
        exit(EXIT_SUCCESS);
    }
}

int main()
{
    signal(SIGTERM, signalHandler);

    while (1)
    {
        counter++;
        std::cout << "Seconds after launch: " + std::to_string(counter) << std::endl;
        sleep(1);
    }

    return 0;
}