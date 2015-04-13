	# suits = ["H", "C", "S", "D"]
  	# faces = [2, 3, 4, 5, 6, 7, 8, 9, "T", "J", "Q", "K", "A"]

  # ranking system to determine winner in game
 	# •	High Card: Highest value card.
 		# go by position in faces array - DONE
	# •	One Pair: Two cards of the same value.
		# if 2 faces are the same - DONE
	# •	Two Pairs: Two different pairs.
		# if 2 faces are the same && 2 different faces are the same - DONE
	# •	Three of a Kind: Three cards of the same value.
		# if 3 faces are the same - DONE
	# •	Straight: All cards are consecutive values.
		# if if 2..6, 3..7, 4..8, 5..9, 6..T, 7..J, 8..Q, 9..K, T..A
	# •	Flush: All cards of the same suit.
		#if all suits are the same: all H or C or S or D - DONE
	# •	Full House: Three of a kind and a pair.
		# if 3 faces are the same && 2 faces are the same - DONE
	# •	Four of a Kind: Four cards of the same value.
		# if 4 faces are the same - DONE
	# •	Straight Flush: All cards are consecutive values of same suit.
		# if 2..6, 3..7, 4..8, 5..9, 6..T, 7..J, 8..Q, 9..K, T..A  && all H or C or S or D
	# •	Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
		# if TJQKA && all H or C or S or D - DONE


	# If two players have the same ranked hands then the rank made up of the highest value wins; 
	# for example, a pair of eights beats a pair of fives. But if two 
	# ranks tie, for example, both players have a pair of queens, then highest cards in each 
	# hand are compared; if the highest cards tie then the next highest 
	# cards are compared, and so on.

def poker
	include Enumerable

	# read file by line
	# make each line a game
	# strip /n off end of each line
	# make each game an array
	# need to loop over each game in the file to determine winner and tally
	
	user1count = 0 # number of games user1 has won
	user2count = 0 # number of games user2 has won
	
	File.open('poker.txt').each do |line|
	
		game = line.strip.split(" ")
		
		userhand1 = game.slice(0,5)
	  	userhand2 = game.slice(5,10)
	  	
	  	game.each do |card|
	  		faces = [2, 3, 4, 5, 6, 7, 8, 9, "T", "J", "Q", "K", "A"].reverse
	  		faces1 = []
	  		faces2 = []
	  		suits1 = []
	  		suits2 = []
	  		
	  		userhand1.each do |card|
	  			faces1 << card[0]
	  			suits1 << card[1]
	  		end
	  		userhand2.each do |card|
	  			faces2 << card[0]
	  			suits2 << card[1]
	  		end

	  		# hashes to check for how many of same face card in each hand
	  		h1 = {}
	  		h2 = {}
	  		# realize these should each happen on one line, but it wasn't working :/
	  		faces1.each { |e| h1[e] = 0 }
			faces1.each{ |e| h1[e] += 1 }
			faces2.each { |e| h2[e] = 0 }
			faces2.each{ |e| h2[e] += 1 }

			matches1 = h1.max_by{|k,v| v} # array with face then number of times it occurs in a hand
			matches2 = h2.max_by{|k,v| v} 

			# Royal flush (assuming only one user will get one at a time)
			if faces1.include?("A") && faces1.include?("K") && faces1.include?("Q") && faces1.include?("J") && faces1.include?("T") && suits1.uniq.length == 0
				user1count += 1
			elsif faces2.include?("A") && faces2.include?("K") && faces2.include?("Q") && faces2.include?("J") && faces2.include?("T") && suits2.uniq.length == 0
				user2count += 1

			# Straight flush
			# See explanation on Straight below

			# Four of a kind
			elsif matches1 == 4 && matches2 <= 4
				user1count += 1
			elsif matches2 == 4 && matches1 <= 4
				user2count += 1

			# Full house
			elsif matches1 == 3 && faces1.uniq.length == 0
				user1count += 1
			elsif matches2 == 3 && faces2.uniq.length == 0
				user2count += 1

			# Flush 
			elsif suits1.uniq.length == 0 && !(suits2.uniq.length == 0)
				user1count += 1
			elsif suits2.uniq.length == 0 && !(suits1.uniq.length == 0)
				user2count += 1
			
			# Straight 
			# here's the stackoverflow discussion this generated: 
			#http://stackoverflow.com/questions/29598289/how-do-you-check-an-array-for-a-range-in-ruby

			# Three of a kind
			elsif matches1 == 3
				user1count += 1
			elsif matches2 == 3
				user2count += 1

			# Two pairs
			elsif matches1 == 2 && faces2.uniq.length == 1
				user1count += 1
			elsif matches2 == 2 && faces2.uniq.length == 1
				user2count += 1

			# One pair
			elsif matches[1] == 2 && !(matches[2] == 2)
				user1count += 1
	  		elsif matches[2] == 2 && !(matches[1] == 2)
		  		user2count += 1

	  		else 
	  			# compare highest cards in each hand
	  			# tally winner
		  		faces.each do |f|
			  		if faces1.uniq.include?(f) && !faces2.uniq.include?(f)  
			  			user1count += 1
			  		elsif faces2.uniq.include?(f) && !faces1.uniq.include?(f)
			  			user2count += 1
			  		end
	  			end
	    	end
	    end
    end
    # give tally for wins per player
	puts "User 1 had #{user1count} wins. User 2 had #{usercount2} wins."
end