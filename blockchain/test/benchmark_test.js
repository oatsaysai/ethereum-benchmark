/* global web3:true, assert:true, artifacts:true, contract:true */
/* eslint-env mocha */

var Benchmark = artifacts.require('Benchmark');

contract('Benchmark', function(accounts) {
  let benchmark;

  before('deploy benchmark', done => {
    Benchmark.new().then(instance => {
      benchmark = instance;
      done();
    });
  });

  it('should have all getters with correct value', async () => {
    var watcher = benchmark.FinishWrite();

    await benchmark.writeData(0, 'data', 3);
    let events = await watcher.get();
    assert.equal(events.length, 1);
    assert.equal(events[0].args.data.valueOf(), 'data');
  });
});
