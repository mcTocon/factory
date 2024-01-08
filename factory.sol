// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

///@author TOCON.IO
///@custom:security-contact support@tocon.io

///_______________________________________________________________________________________________________       
///_______/\\\__________________________________________________________________________/\\\_______________      
///_____/\\\\\\\\\\\_____/\\\\\________/\\\\\\\\_____/\\\\\_____/\\/\\\\\\______________\///______/\\\\\____     
///_____\////\\\////____/\\\///\\\____/\\\//////____/\\\///\\\__\/\\\////\\\______________/\\\___/\\\///\\\__    
///_________\/\\\_______/\\\__\//\\\__/\\\__________/\\\__\//\\\_\/\\\__\//\\\____________\/\\\__/\\\__\//\\\_   
///__________\/\\\_/\\__\//\\\__/\\\__\//\\\________\//\\\__/\\\__\/\\\___\/\\\____________\/\\\_\//\\\__/\\\__  
///___________\//\\\\\____\///\\\\\/____\///\\\\\\\\__\///\\\\\/___\/\\\___\/\\\____/\\\____\/\\\__\///\\\\\/___ 
///_____________\/////_______\/////________\////////_____\/////_____\///____\///____\///_____\///_____\/////_____
///_______________________________________________________________________________________________________________                 

// Explicit imports from OpenZeppelin
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract NEW_FACTORY {
    using Address for address;

    event InstanceDeployed(address indexed implementation, address proxy, address indexed deployer);

    function deploy(
        address _implementation,
        bytes32 _salt,
        bytes memory _initData
    ) public returns (address instance) {
        bytes32  salthash = keccak256(abi.encodePacked(msg.sender, _salt));
        instance = Clones.cloneDeterministic(_implementation, salthash);
        instance.functionCall(_initData);
        emit InstanceDeployed(_implementation, instance, msg.sender);
    }


}
