(ns burning_ideas.ideas
  (:require [clj-time.core :as clj-time]
            [cheshire.core :as json]))

(def ideas-hash (atom {}))

(defn current-hotness [idea]
  (let [last-reset (:last-reset idea)
        time-diff (clj-time/in-secs (clj-time/interval last-reset (clj-time/now)))]
    (max (- 100 time-diff) 0)))

(defn find-idea [id]
  (val (find @ideas-hash id)))

(defn modify-hotness [id]
  (let [oldIdea (find-idea id)
        newIdea (assoc oldIdea :last-reset (clj-time/now))]
    (swap! ideas-hash assoc id newIdea)
    newIdea))

(defn next-id []
  (if (zero? (count @ideas-hash))
    0
    (+ 1 (apply max (keys @ideas-hash)))))

(defn build-idea [data]
  (let [parsed-data (json/parse-string data true)]
    (conj parsed-data {:id (next-id) :last-reset (clj-time/now)})))

(defn add-idea [data]
  (let [new-idea (build-idea data)]
    (swap! ideas-hash assoc (:id new-idea) new-idea)
    new-idea))

(defn all-ideas []
  (vals @ideas-hash))

