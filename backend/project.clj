(defproject burning_ideas "1.0.0-SNAPSHOT"
  :description "FIXME: write description"
  :dependencies [[org.clojure/clojure "1.3.0"]
                 [org.clojure/clojure-contrib "1.2.0"]
                 [compojure "0.6.4"]
                 [cheshire "2.0.6"]
                 [clj-time "0.1.0-SNAPSHOT"]]
  :dev-dependencies [[lein-ring "0.4.5"]]
  :ring {:handler burning_ideas.core/app})

