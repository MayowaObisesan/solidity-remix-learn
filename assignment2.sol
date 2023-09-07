// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


// task: Create a smart contract that showcases various exemplary scenarios by utilizing nested structs and mappings 
// within a primary struct. Within the main struct, integrate a secondary struct, and within this secondary struct, 
// establish a mapping that links it to another struct. Moreover, incorporate an enumeration declaration within the main struct. 
// Conclude by implementing a function that allows for the retrieval of information from the deepest nested struct.

contract PlayerClub {
    enum LeagueQuality {
        Platinum,
        Gold,
        Silver,
        Bronze
    }

    struct Club {
        uint standing;
        string name;
    }

    struct League {
        string name;
        mapping(uint => Club) position;
        string country;
    }

    struct Player {
        string name;
        League league;
        LeagueQuality leagueQuality;
    }

    Club public currentClub;
    League league;
    Player player;

    function createClub(uint _standing, string memory _name) public {
        currentClub.standing = _standing;
        currentClub.name = _name;
    }

    function createLeague(string memory _name, string memory _country) public {
        league.name = _name;
        league.country = _country;
        league.position[currentClub.standing] = currentClub;
    }

    function createPlayer(string memory _name, LeagueQuality _leagueQuality) public {
        player.name = _name;
        player.league.name = league.name;
        player.league.position[currentClub.standing] = currentClub;
        player.league.country = league.country;
        player.leagueQuality = _leagueQuality;
    }

    function getPlayerClubName(uint clubId) public view returns (string memory) {
        return player.league.position[clubId].name;
    }
}


contract PlayerClub2 {
    enum LeagueQuality {
        Platinum,
        Gold,
        Silver,
        Bronze
    }

    struct Club {
        uint standing;
        string name;
    }

    struct League {
        string name;
        mapping(uint => Club) position;
        string country;
    }

    struct Player {
        string name;
        League league;
        LeagueQuality leagueQuality;
    }

    Club public currentClub;
    League league;
    Player player;

    function createClub(uint _standing, string memory _name) private {
        currentClub.standing = _standing;
        currentClub.name = _name;
    }

    function createLeague(string memory _name, string memory _country, string memory _clubName, uint _clubPosition) private {
        league.name = _name;
        league.country = _country;
        league.position[_clubPosition] = Club(currentClub.standing++, _clubName);
    }

    function createPlayer(string memory _name, uint _clubPosition, string memory _clubName, LeagueQuality _leagueQuality) public {
        // create Club first before creating player
        currentClub.standing = currentClub.standing++;
        currentClub.name = _clubName;

        // create league next
        league.name = league.name;
        league.country = league.country;
        league.position[_clubPosition] = currentClub;

        // Then create player
        player.name = _name;
        player.league.name = league.name;
        player.league.position[_clubPosition] = currentClub;
        player.league.country = league.country;
        player.leagueQuality = _leagueQuality;
    }

    function getPlayerClubName(uint clubId) public view returns (string memory) {
        return player.league.position[clubId].name;
    }
}