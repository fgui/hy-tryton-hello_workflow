(import [trytond.pool [PoolMeta]]
        [trytond.model [ModelView Workflow fields]]
        [trytond.pyson [Eval If Bool]])
(require [trytond.modules.hyton.sugar [default-value]])

(defclass Hello [:metaclass PoolMeta Workflow]
  "Hellow World with Workflow"
  [--name-- "hello"
   state (.Selection fields
                     [(, "draft" "Draft")
                      (, "baby" "Baby")
                      (, "adult" "Adult")
                      (, "dead" "Dead")]
                     "Status":readonly True) ]

  (default-value state "draft")

  #@(classmethod
      (defn --setup-- [cls]
        (.--setup-- (super))
        (setv cls._transitions
              (| cls._transitions
                 #{
                   (, "draft" "baby")
                   (, "baby" "adult")
                   (, "baby" "dead")
                   (, "adult" "dead")
                   }))
        (.update cls._buttons
                 {"draft" {"invisible" (!= (Eval "state") "draft")
                           "depends" ["state"]}
                  "baby" {"invisible" (.in_ (Eval "state") ["adult" "dead"])
                           "depends" ["state"]}
                  "adult" {"invisible" (.in_ (Eval "state") ["draft" "dead"])
                           "depends" ["state"]}
                  "dead" {"invisible" (.in_ (Eval "state") ["draft"])
                          "depends" ["state"]}
                  })
        ))

  #@(classmethod
     ModelView.button
     (Workflow.transition "draft")
     (defn draft [cls hellos] ))
  
  #@(classmethod
     ModelView.button
     (Workflow.transition "baby")
     (defn baby [cls hellos] ))
  
  #@(classmethod
     ModelView.button
     (Workflow.transition "adult")
     (defn adult [cls hellos] ))
  
  #@(classmethod
     ModelView.button
     (Workflow.transition "dead")
     (defn dead [cls hellos] ))
  

  )
