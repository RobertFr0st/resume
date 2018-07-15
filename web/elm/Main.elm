module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (property)
import Html.Events exposing (onClick)
import Json.Encode as Json exposing (string)

main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Skill = 
  { id : Int
  , name : String
  , user_id : Int
  --, inserted_at : 
  --, updated_at : 
  }

type alias Model =
   List Skill
 


model : Model -> Model
model skills =
    skills



-- UPDATE

type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model

    Decrement ->
      model



-- VIEW

view : Model -> Html Msg
view model =
  div [ property "className" (Json.string "row justify-content-center") ]
    [
      div [ property "className" (Json.string "col-6") ]
      [ text "test" ],

      div [ property "className" (Json.string "col-6") ]
      [ text "test" ]
    ]
