module Constants.Api exposing (..)

import Json.Decode as Decode
import Models.Models as Models exposing (Player, PlayerId)
import Json.Decode.Pipeline exposing (decode, required)


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:8001/players"


playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int


savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
    "http://localhost:8001/players/" ++ playerId
