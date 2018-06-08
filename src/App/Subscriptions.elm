module App.Subscriptions exposing (..)

import Models.Models as Models exposing (Model)
import Messages.Msgs as Msgs exposing (Msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
