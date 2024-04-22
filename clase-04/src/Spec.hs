module Spec where
import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)
import Test.Hspec.Runner (Config(..), defaultConfig, hspecWith)
import Test.Hspec.Formatters (specdoc)

correrTests :: IO ()
correrTests = runHspec $ do
  describe "Recursividad" $ do
    describe "multiplicar" $ do
      it "Un numero multiplicado por 0 es 0" $ do
        multiplicar 3 0 `shouldBe` 0
      it "Un numero N multiplicado por un numero M es el resultado de sumar M veces N" $ do
        multiplicar 3 6 `shouldBe` 18
  describe "Listas" $ do
    describe "Primero" $ do
      it "Si la lista tiene elementos, me devuelve el primero" $ do
        primero [1,2,3] `shouldBe` 1
      it "Si la lista no tiene elementos, deberia fallar" $ do
        deberiaFallar (primero [])
    describe "Ultimo" $ do
      it "Si la lista tiene elementos, me devuelve el ultimo" $ do
        ultimo [1,2,3] `shouldBe` 3
      it "Si la lista no tiene elementos, deberia fallar" $ do
        deberiaFallar (ultimo [])
    describe "Cantidad" $ do
      it "Si la lista no tiene elementos, es 0" $ do
        cantidad [] `shouldBe` 0
      it "Si la lista tiene elementos, es la cantidad de elementos en la lista" $ do
        cantidad ["uno", "dos", "tres", "cuatro"] `shouldBe` 4
    describe "Tiene" $ do
      it "Si el elemento esta contenido en la lista, es True" $ do
        tiene "hola" ["hola", "mundo!"] `shouldBe` True
      it "Si el elemento no esta contenido en la lista, es False" $ do
        tiene "pdep" ["hola", "mundo!"] `shouldBe` False
    describe "agregar" $ do
      it "Devuelve la lista con el elemento agregado al principio" $ do
        agregar 'a' "bc" `shouldBe` "abc"
    describe "agregarAlFinal" $ do
      it "Devuelve la lista con el elemento agregado al principio" $ do
        agregar 'z' "abc" `shouldBe` "abcz"
    describe "agregarTodos" $ do
      it "Agrega todos los elementos de la segunda lista a la primera al final de la misma" $ do
        agregar [1,2,3] [4,5,6] `shouldBe` [1,2,3,4,5,6]
      
    

deberiaFallar :: a -> Expectation
deberiaFallar unaExpresion = evaluate unaExpresion `shouldThrow` anyException

runHspec :: Spec -> IO ()
runHspec tests = hspecWith defaultConfig {configFormatter = Just specdoc} tests