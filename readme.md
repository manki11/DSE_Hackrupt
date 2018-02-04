#DSE

#### Decentralised Stocks Exchange ####

A decentralized stocks exchange. Today's Stck Exchange has a number of problems that can be solved by introducing Blockchain. The problems faced by stock exchanges today are-
1. Insider Trading
2. Third party involvement
3. Price of transaction
4. Little or no Transparency

By developing a decentralized stock change all transactions on the chain will pe public, thus making it less vulnerable to fraud and deceit.

#### Project ScreenShots

![Alt text](images/DSE_home.png?raw=true)

![Alt text](images/DSE_sell.png?raw=true)

![Alt text](images/DSE_change.png?raw=true)

![Alt text](images/DSE_trading?raw=true)


#### Steps to run project ####

Make sure npm and nodejs are installed on your machine.
Metamask extension in chrome would be recommended.

Clone the repository on your local machine and run.

```bash
npm install
```

##### Setting up the development environment 

```bash
npm install -g ethereumjs-testrpc
```

```bash
npm install -g truffle
```

##### Running the project

Run test-rpc

```bash
./starttestrpc.sh
```

Compile project

```bash
truffle compile
```

Deploy project

```bash
truffle migrate
```

Run Web-App

```bash
npm run dev
```
