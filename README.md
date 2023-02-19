# ignite_blockchain
### The project in short
This smart contract is a sample MVP for the project work presented for the fourth edition of MasterZ Blockchain program.    
The Project Work chosen has the objective of creating a web3 platform where users will find training materials regarding the blockchain. Users will receive rewards based on time spent on the platform, watched videos, read articles and correctly performed quizzes. The rewards can be used to unlock subsequent modules and other premium content, donated to charity organizations or withdrawn.    
The contract is essentially a backend module which offers various functionalities that can be an exemplification - and a simplification - of the ones that the actual application would present.   
### More details
In detail, it allows users to create their profile, to update it and, more importantly, saves on-chain their "progresses", i.e. how many minutes of a video course have been seen for each user and which quizzes they have answered to.
In addition there's the possibility for the admins to upload new courses, each one with the proper number of gems.   
### About gems
Gems are awarded according to the percentage of watched videos and to the number of correct answers to quizzes.   
As an example, if the vision of a specific course is worth in total 100 gems (following the decision of one of the admins) and a user has seen half of the videos, they will be awarded 50 gems, plus all the gems coming from the correct answers to the intermediate quizzes.

### Contribute to the project
You can contribute to the repository at any time by forking it and submitting a pull request.   
If you are interested in Ignite Blockchain, you could find useful the following documentation:

- [Quick Start](https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html)
- [SDK Developer Tools](https://sdk.dfinity.org/docs/developers-guide/sdk-guide.html)
- [Motoko Programming Language Guide](https://sdk.dfinity.org/docs/language-guide/motoko.html)
- [Motoko Language Quick Reference](https://sdk.dfinity.org/docs/language-guide/language-manual.html)
