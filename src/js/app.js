App = {
    web3Provider: null,
    contracts: {},
    account: 0x0,
    loading: false,

    init: function() {
        return App.initWeb3();
    },

    initWeb3: function() {
        // Initialize web3 and set the provider to the testRPC.
        if (typeof web3 !== 'undefined') {
            App.web3Provider = web3.currentProvider;
            web3 = new Web3(web3.currentProvider);
        } else {
            // set the provider you want from Web3.providers
            App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
            web3 = new Web3(App.web3Provider);
        }
        App.displayAccountInfo();
        return App.initContract();
    },

    displayAccountInfo: function() {
        web3.eth.getCoinbase(function(err, account) {
            if (err === null) {
                App.account = account;
                $("#account").text(account);
                web3.eth.getBalance(account, function(err, balance) {
                    if (err === null) {
                        $("#accountBalance").text(web3.fromWei(balance, "ether") + " ETH");
                    }
                });
            }
        });
    },

    initContract: function() {
      $.getJSON('DSE.json', function(Artifact) {
          // Get the necessary contract artifact file and use it to instantiate a truffle contract abstraction.
          App.contracts.DSE = TruffleContract(Artifact);

          // Set the provider for our contract.
          App.contracts.DSE.setProvider(App.web3Provider);

          // Listen for events
          App.listenToEvents();

          // Retrieve the article from the smart contract
          return App.setuser();

      });
  },

    setuser: function () {
        // avoid reentry
        if (App.loading) {
            return;
        }
        App.loading = true;

        // refresh account information because the balance may have changed
        App.displayAccountInfo();
        console.log("1");
        var DSEInstance;

        App.contracts.DSE.deployed().then(function(instance) {
            DSEInstance = instance;
            console.log("2");
            return DSEInstance.setUser(App.account);
        }).then(function (result) {
            console.log("3");
            console.log(result);
            return App.stockList();
        }).catch(function(err) {
            console.log("4");
            console.log(err.message);
            App.loading = false;
        });
    },

    stockList: function () {
        App.contracts.DSE.deployed().then(function(instance) {
            return instance.getNoOfStockOfUser(App.account);
        }).then(function(object) {
            console.log(object)

        }).catch(function(err) {
            console.log(err.message);
            App.loading = false;
        })
    },

    addDemoStock: function() {
        App.contracts.DSE.deployed().then(function(instance) {
            return instance.addStock("AAPL",30,App.account,50);
        }).then(function(object) {
            console.log(object)

        }).catch(function(err) {
            console.log(err.message);
            App.loading = false;
        })
    },

    // Listen for events raised from the contract
    listenToEvents: function() {
        App.contracts.DSE.deployed().then(function(instance) {
            instance.addStockEvent({}, {
                fromBlock: 0,
                toBlock: 'latest'
            }).watch(function(error, event) {
                console.log(event);
                // $("#events").append('<li class="list-group-item">' + event.args._name + ' is for sale' + '</li>');
                // App.reloadArticles();
            });

            // instance.buyArticleEvent({}, {
            //     fromBlock: 0,
            //     toBlock: 'latest'
            // }).watch(function(error, event) {
            //     console.log(event);
            //     $("#events").append('<li class="list-group-item">' + event.args._buyer + ' bought ' + event.args._name + '</li>');
            //     App.reloadArticles();
            // });
        });
    },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markAdopted: function(adopters, account) {
    /*
     * Replace me...
     */
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
