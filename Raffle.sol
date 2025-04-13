// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Raffle
 * @author Adeola
 * @notice This contract is for a simple raffle game.
 * @dev Implements Chainlink VRF for randomness.
 */
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts@1.3.0/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";

contract Raffle {
    // Errors
    error Raffle_NotEnoughEth();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    //@dev duration of raffle in seconds
    uint256 private immutable i_interval;
    uint256 private s_lastTimeStamp;

    //Events
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle_NotEnoughEth();
        }

        // Enter the raffle
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external {
        block.timestamp - s_lastTimeStamp >= i_interval;
        if (block.timestamp - s_lastTimeStamp < i_interval) {
            revert();
        }

        requestId = s_vrfCoordinator.requestRandomWords(
            VRFV2PlusClient.RandomWordsRequest({
                keyHash: keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({
                        nativePayment: enableNativePayment
                    })
                )
            })
        );
    }

    // Getter functions
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
