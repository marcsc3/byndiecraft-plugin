package com.bynder.byndiecraft.jira;

public class TransitionRequest {
    private final Transition transition;

    public TransitionRequest(String transitionId) {
        this.transition = new Transition(transitionId);
    }

    public Transition getTransition() {
        return transition;
    }

    public static class Transition {
        private final String id;

        public Transition(String id) {
            this.id = id;
        }

        public String getId() {
            return id;
        }
    }
}
