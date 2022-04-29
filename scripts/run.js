const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy('42');
    await domainContract.deployed();
    console.log("contract deployed to:", domainContract.address);
    console.log("contract owner address:", owner.address);

    const txn = await domainContract.register("mortal.pol",{value:hre.ethers.utils.parseEther('0.1')});
    await txn.wait();

    const domainOwner = await domainContract.getAddress("mortal.pol");
    console.log(domainOwner);


    const balance = await hre.ethers.provider.getBalance(domainContract.address);
    console.log(hre.ethers.utils.formatEther(balance));
}   

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();