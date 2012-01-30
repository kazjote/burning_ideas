(ns burning_ideas.core
  (:use compojure.core)
  (:require [compojure.route :as route]
            [compojure.handler :as handler]
            [cheshire.core :as json]
            [clojure.contrib.duck-streams :as duck-streams]
            [burning_ideas.ideas :as ideas]))

(defn debug [msg]
  (locking System/out (println msg)))

(defn client-idea [idea]
  (assoc (dissoc idea :last-reset) :hotness (ideas/current-hotness idea)))

(defroutes main-routes
  (GET "/" []
    {:status 301
     :headers {"Location" "/index.html"}})
  (GET "/ideas" []
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string (map client-idea (ideas/all-ideas)))})
  (POST "/ideas" {body :body}
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string
             (client-idea (ideas/add-idea (duck-streams/slurp* body))))})
  (PUT "/ideas/:id" [id]
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string
             (client-idea (ideas/modify-hotness (Integer/parseInt id))))})
  (route/resources "/")
  (route/not-found "Page not found"))

(def app
  (handler/site main-routes))

