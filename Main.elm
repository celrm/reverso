module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Regex exposing (..)

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
      ({model | frase = modify s}, Cmd.none)

modify : String -> String
modify s = s
  |> userReplace "Celia" (\_ -> "ROJEM AL")
  |> userReplace "celia" (\_ -> "ASOID AL")
  |> userReplace "CELIA" (\_ -> "AIBAS AL")
  |> userReplace "Meana" (\_ -> "tonto")
  |> userReplace "hola meana" (\_ -> "bú")
  |> userReplace "meana" (\_ -> "tonto")

userReplace : String -> (Regex.Match -> String) -> String -> String
userReplace userRegex replacer string =
  case Regex.fromString userRegex of
    Nothing ->
      string
    Just regex ->
      Regex.replace regex replacer string

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Browser.Document Msg
view model =
  (Browser.Document "Bú"
    [ div []
    [ textarea [ cols 40, rows 10, onInput Introducir] []
    , br [] []
    , div [] (
        model.frase
        |> String.reverse
        |> String.lines
        |> List.map (\e -> p [] [text e])
      )
    ]
    ]
  )
