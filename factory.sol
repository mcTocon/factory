// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

///_______________________________________________________________________________________________________       
////______/\\\__________________________________________________________________________/\\\_______________      
/////___/\\\\\\\\\\\_____/\\\\\________/\\\\\\\\_____/\\\\\_____/\\/\\\\\\______________\///______/\\\\\____     
//////__\////\\\////____/\\\///\\\____/\\\//////____/\\\///\\\__\/\\\////\\\______________/\\\___/\\\///\\\__    
///////_____\/\\\_______/\\\__\//\\\__/\\\__________/\\\__\//\\\_\/\\\__\//\\\____________\/\\\__/\\\__\//\\\_   
////////_____\/\\\_/\\__\//\\\__/\\\__\//\\\________\//\\\__/\\\__\/\\\___\/\\\____________\/\\\_\//\\\__/\\\__  
/////////_____\//\\\\\____\///\\\\\/____\///\\\\\\\\__\///\\\\\/___\/\\\___\/\\\____/\\\____\/\\\__\///\\\\\/___ 
//////////______\/////_______\/////________\////////_____\/////_____\///____\///____\///_____\///_____\/////_____
///////////_______________________________________________________________________________________________________                 

// Explicit imports from OpenZeppelin
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/utils/Address.sol";

/**
 * @title NEW_FACTORY Contract
 * @author TOCON.IO
 * @custom:security-contact security@awesome.com
 * @notice This contract is used for creating new contract instances using the EIP-1167 minimal proxy pattern.
 * @dev This contract utilizes OpenZeppelin's Clones library for deploying minimal proxies.
 */
contract NEW_FACTORY {
    using Address for address;

    /// @notice Emitted when a new instance is deployed.
    /// @param implementation The address of the implementation contract.
    /// @param proxy The address of the newly created proxy.
    /// @param deployer The address of the deployer.
    event InstanceDeployed(address indexed implementation, address proxy, address indexed deployer);

    /// @notice Deploys a new contract instance using a minimal proxy pattern.
    /// @dev Uses EIP-1167 minimal proxy pattern for deployment.
    /// @param _implementation The address of the implementation contract to clone.
    /// @param _salt A unique salt used to determine the proxy contract's address.
    /// @param _initData The initialization data to be passed to the proxy contract.
    /// @return instance The address of the newly deployed proxy contract.
    function deploy(
        address _implementation,
        bytes32 _salt,
        bytes memory _initData
    ) external returns (address instance) {
        bytes32  salthash = keccak256(abi.encodePacked(msg.sender, _salt));
        instance = Clones.cloneDeterministic(_implementation, salthash);
        instance.functionCall(_initData);
        emit InstanceDeployed(_implementation, instance, msg.sender);
    }
}
