(ns burning_ideas.core
  (:use compojure.core clojure.contrib.duck-streams)
  (:require [compojure.route :as route]
            [compojure.handler :as handler]
            [cheshire.core :as json]))

(def ideas (atom [{:id 1 :description "Start your brainstorming!"}]))

; (defn next-id
;   (apply max (map #(:id %) @ideas)))

(defn debug [msg]
  (locking System/out (println msg)))

(defn build-idea [data]
  (let [parsed-data (json/parse-string data true)]
    (conj parsed-data {:id 1})))

(defn add-idea [data]
  (let [new-idea (build-idea data)]
    (swap! ideas conj new-idea)
    new-idea))

(defroutes main-routes
  (GET "/" [] "<h1>Hello World Wide Web!</h1>")
  (GET "/ideas" []
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string @ideas)})
  (POST "/ideas" {body :body}
    (debug body)
    {:status 200
     :headers {"Content-Type" "application/json"}
     :body (json/generate-string (add-idea (slurp* body)))})
  (route/resources "/")
  (route/not-found "Page not found"))

(def app
  (handler/site main-routes))
