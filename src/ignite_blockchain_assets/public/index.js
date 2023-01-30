import ignite_blockchain from 'ic:canisters/ignite_blockchain';

ignite_blockchain.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
