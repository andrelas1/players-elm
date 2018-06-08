module App.Commands exposing (..)

import Http
import Json.Encode as Encode
import Messages.Msgs as Msgs exposing (Msg)
import Models.Models as Models
    exposing
        ( PlayerId
        , Player
        , User
        )
import RemoteData
import Constants.Api
    exposing
        ( fetchPlayersUrl
        , playersDecoder
        , playerDecoder
        , savePlayerUrl
        )


-- SIDE EFFECTS


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPlayerSave


savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


createPlayerRequest : Player -> Http.Request Player
createPlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = fetchPlayersUrl
        , withCredentials = False
        }


createPlayerCmd : Player -> Cmd Msg
createPlayerCmd player =
    createPlayerRequest player
        |> Http.send Msgs.OnPlayerCreate


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        Encode.object attributes


loginUser : User -> Cmd Msg
loginUser user =
    let
        _ =
            Debug.log "User" user
    in
        Cmd.none
