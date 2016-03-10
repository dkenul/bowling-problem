# Suppose game is an array of arrays representing score per turn
# Assume we are given actual point representations in each tuple:
# Strike -> [10, 0]
# Spare -> [2, 8] or any combination that adds to 10
# Assume 10th frame is always a tuple in the form [x, y, z]
# if zth position is not reached, it still contains a placeholder 0
# Assume that if we are not given a complete game, strike should be calculated as:
# normal if there are additional frames, +0 bonus if there are no additional frames

def score(game)

  return "invalid" unless is_valid?(game)

  total_score = 0

  game.each_with_index do |frame, i|
    next_frame = game[i + 1]
    next_next_frame = is_strike?(next_frame) ? game[i + 2] : nil

    if i == 7
      next_next_frame = is_strike?(next_frame) ? [game[9][0], 0] : nil
    elsif i == 8
      next_frame = [game[9][0], 0]
      next_next_frame = [game[9][1], 0]
    end

    if i == 9
      total_score += frame[0] + frame[1] + frame[2]
    elsif is_strike?(frame)
      total_score += 10 + score_frame(next_frame) + score_frame(next_next_frame)
    elsif next_frame && is_spare?(frame)
      total_score += 10 + next_frame.first
    else
      total_score += score_frame(frame)
    end
  end

  total_score
end

# Helper Methods

def is_valid?(game)
  game.is_a?(Array) && game.length <= 10 && game.all? do |frame|
    frame.is_a?(Array) &&
    frame[0].is_a?(Integer) &&
    frame[1].is_a?(Integer)
  end
end

def score_frame(frame)
  return 0 if frame.nil?

  frame[0] + frame[1]
end

def is_strike?(frame)
  return false if frame.nil?

  frame[0] == 10
end

def is_spare?(frame)
  !is_strike?(frame) && score_frame(frame) == 10
end
