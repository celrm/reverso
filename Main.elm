module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

type alias Model =
  { frase : String
  }

type Msg =
  Introducir String

init : () -> (Model, Cmd Msg)
init _ =
  ({frase = ""}, Cmd.none)

update : Msg -> Model -> (Model,Cmd Msg)
update msg model =
  case msg of
    Introducir s ->
      ({model | frase = s}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Browser.Document Msg
view model =
  (Browser.Document "Hola Meana"
    [ div []
    [ input [onInput Introducir] []
    , br [] []
    , text (String.reverse model.frase)
    ]
    ]
  )
