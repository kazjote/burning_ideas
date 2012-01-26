(ns burning_ideas.core
  (:use compojure.core)
  (:require [compojure.route :as route]
            [compojure.handler :as handler]
            [cheshire.core :as json]))

(defroutes main-routes
  (GET "/" [] "<h1>Hello World Wide Web!</h1>")
  (GET "/ideas" []
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string '[{:hotness 100.0} {:description "Cool stuff"}])})
  (POST "/ideas" [] "Cool")
  (route/resources "/")
  (route/not-found "Page not found"))

(def app
  (handler/site main-routes))
