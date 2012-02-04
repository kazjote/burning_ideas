(ns burning_ideas.test.ideas
  (:require [clj-time.core :as clj-time])
  (:use [burning_ideas.ideas])
  (:use [clojure.test]))

(defn idea-reset-in-past [interval]
  {:last-reset (clj-time/minus (clj-time/now) interval)})

(deftest determine-current-hotness
  (let [idea (idea-reset-in-past (clj-time/secs 1))]
    (is (= 99 (current-hotness idea))))

  (let [idea (idea-reset-in-past (clj-time/days 1))]
    (is (= 0 (current-hotness idea)))))

(deftest modifying-hotness
  (let [idea (idea-reset-in-past (clj-time/days 1))]
    (swap! ideas-hash assoc 1 idea)
    (let [returned-idea (modify-hotness 1)]
      (is (= 100 (current-hotness returned-idea)))
      (is (= 100 (current-hotness (find-idea 1)))))))

