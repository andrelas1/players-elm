module Pages.Login exposing (view)

import Messages.Msgs as Msgs exposing (Msg(OnLoginSubmit, OnUsernameChange, OnPasswordChange))
import Html exposing (div, text, Html, input, form, h2, label, button)
import Html.Attributes exposing (class, placeholder, id, type_)
import Html.Events exposing (onClick, onSubmit, onInput)


view : Html Msg
view =
    div
        [ class "flex items-center justify-center"
        , id "login"
        ]
        [ form
            [ class "flex border"
            , id "login-form"
            , onSubmit <| OnLoginSubmit
            ]
            [ div
                [ class "flex flex-wrap items-center justify-center"
                , id "login-fieldset"
                ]
                [ h2 [ class "col-12" ] [ text "LOGIN" ]
                , div
                    [ class "col-12" ]
                    [ label [] [ text "Username" ]
                    , input
                        [ placeholder "username", onInput <| OnUsernameChange ]
                        []
                    ]
                , div [ class "col-12" ]
                    [ label []
                        [ text "password" ]
                    , input
                        [ placeholder "password", onInput <| OnPasswordChange ]
                        []
                    ]
                ]
            , button
                [ type_ "submit"
                ]
                [ text "LOGIN" ]
            ]
        ]
