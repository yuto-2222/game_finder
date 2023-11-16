module NotificationsHelper

	def transition_path(notification)
    case notification.action.to_sym
    when :commented_to_own_review
      game_review_path(notification.subject.review.game, notification.subject.review, anchor: "comment-#{notification.subject.id}")
    when :useful_to_own_review
      game_review_path(notification.subject.review.game, notification.subject.review)
    end
	end
end
