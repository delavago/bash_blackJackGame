#!/bin/bash

input
wager=0.0
# Create an empty "shoe" (array), to hold a deck of 52 cards:
user_hand_value=0
dealer_hand_value=0
shoe=()
userDec=()
dealerDec=()

echo Welcome to Black-Jack!  Would you like to see the rules? \(y/n\)

rules () {
    echo "Rules:
    1. Jack Queen King are worth 10pts each
    2. Ace has a value of 11
    3. Numbered cards (2 through 10) maintain their value 4. You WIN, if
    [2mks]
    • Player = 21; then double wager
    • Player < 21 & Computer < 21 & Player < Computer; then 1.5*wager
    • Player < 21 & Computer > 21; then 1.5*wager
    5. You LOSE wager, if
    • Player > 21
    • Player < 21 & Computer ≤ 21 & Computer < Player What is your wager?"
}

# This function shuffles the (global) array "shoe":
shuffle () {
   local i j temp
   for (( i=${#shoe[@]}; i ; --i ))
   do
      j=$(( $RANDOM % i ))
      temp=${shoe[i]}
      shoe[i]=${shoe[j]}
      shoe[j]=$temp
   done
}

# This function deals and returns (in "$?") one card, then
# removes it from the shoe.  When the shoe is empty, a new
# deck is created and shuffled:
deal () {
   if [ ${#shoe[@]} -eq 0 ] #checks in the array is 
   then
     shoe=(`seq 1 52`)
     shuffle
   fi

   local card=${shoe[0]} #creates a local variable that is only available in this function
   # The next two lines remove the first card from the shoe:
   unset shoe[0] # deletes this value from the array
   shoe=(${shoe[@]})
   return $card
}

# this function nicely displays a player's hand, which
# is really an array of ints 0..51 representing cards:
show_hand () {
    A="A";two="2";three="3";four="4";five="5";six="6";seven="7";eigth="8";nine="9";ten="10";jack="J";queen="Q";king="K"
    H="H";S="S";D="D";C="C"
    end=0;offset=0;pos=0
    counter=1
    user_hand_value=0
    for i in "${userDec[@]}" 
    do
        if (( $i >= 1 && $i <= 13 )); then
            end=13
            printf "H"
        elif (( $i >= 14 && $i <= 26 )); then
            end=26
             printf "S"
        elif (( $i >= 27 && $i <= 39 )); then
            end=39
             printf "D"
        elif (( $i >= 40 && $i <= 52 )); then
            end=52
             printf "C"
        fi

        offset=$((end-i))
        pos=$((13-offset))

        if (($pos == 1)); then 
            printf "$A "
             let "user_hand_value+=11" 
        fi

        if (($pos == 2)); then 
            printf "$two " 
             let "user_hand_value+=pos"
        fi

        if (($pos == 3)); then 
            printf "$three " 
             let "user_hand_value+=pos"
        fi
        
        if (($pos == 4)); then 
            printf "$four " 
             let "user_hand_value+=pos"
        fi

        if (($pos == 5)); then 
            printf "$five " 
             let "user_hand_value+=pos"
        fi

        if (($pos == 6)); then 
            printf "$six " 
             let "user_hand_value+=pos"
        fi

        if (($pos == 7)); then 
            printf "$seven "
             let "user_hand_value+=pos" 
        fi

        if (($pos == 8)); then 
            printf "$eigth " 
             let "user_hand_value+=pos"
        fi

        if (($pos == 9)); then 
            printf "$nine " 
             let "user_hand_value+=pos" 
        fi

        if (($pos == 10)); then 
            printf "$ten " 
             let "user_hand_value+=pos" 
        fi

        if (($pos == 11)); then 
            printf "$jack " 
            let "user_hand_value+=10"
        fi

        if (($pos == 12)); then 
            printf "$queen " 
            let "user_hand_value+=10"
        fi

        if (($pos == 13)); then 
            printf "$king" 
            let "user_hand_value+=10"
        fi
    done
}

# this function nicely displays a player's hand, which
# is really an array of ints 0..51 representing cards:
show_hand_dealer () {
    A="A";two="2";three="3";four="4";five="5";six="6";seven="7";eigth="8";nine="9";ten="10";jack="J";queen="Q";king="K"
    H="H";S="S";D="D";C="C"
    end=0;offset=0;pos=0
    dealer_hand_value=0
    counter=1
    for i in "${dealerDec[@]}" 
    do
        if (( $i >= 1 && $i <= 13 )); then
            end=13
            printf "H"
        elif (( $i >= 14 && $i <= 26 )); then
            end=26
             printf "S"
        elif (( $i >= 27 && $i <= 39 )); then
            end=39
             printf "D"
        elif (( $i >= 40 && $i <= 52 )); then
            end=52
             printf "C"
        fi

        offset=$((end-i))
        pos=$((13-offset))

       if (($pos == 1)); then 
            printf "$A "
            let "dealer_hand_value+=11"
        fi

        if (($pos == 2)); then 
            printf "$two " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 3)); then 
            printf "$three " 
        fi
        
        if (($pos == 4)); then 
            printf "$four " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 5)); then 
            printf "$five " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 6)); then 
            printf "$six " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 7)); then 
            printf "$seven "
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 8)); then 
            printf "$eigth " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 9)); then 
            printf "$nine " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 10)); then 
            printf "$ten " 
            let "dealer_hand_value+=pos"
        fi

        if (($pos == 11)); then 
            printf "$jack " 
            let "dealer_hand_value+=10"
        fi

        if (($pos == 12)); then 
            printf "$queen " 
            let "dealer_hand_value+=10"
        fi

        if (($pos == 13)); then 
            printf "$king " 
            let "dealer_hand_value+=10"
        fi

    done
}

show_hands () {
    printf "Player's hand: "
    show_hand
    printf "\n"
    printf "Dealer's hand: "
    show_hand_dealer
    printf "\n"
}

# when reading into a variable
# don't use the the dollar sign
read input

if [ "$input" == "y" ]; then
    rules
fi


# -----------Main Logic---------

# populate user deck
deal
userDec=($?)
deal
userDec+=($?)

# Populate the dealer deck
deal
dealerDec=($?)
deal
dealerDec+=($?)

printf "\n"

echo Enter starting Wager:
read wager

win_flag=false
continue_program=true

while $continue_program
do

    show_hands
    printf "Wager: $wager \n"
    printf "Hand Value: $user_hand_value \n"
    printf "Dealer Hand Value: $dealer_hand_value \n"

    if $continue_program; then 
        printf "S: Stop playing  H: Draw another card from deck  D: Double wager and draw one, and only one more card\n
                What is your choice? \n"
        read input

        if [ "$input" == "S" ]; then
            continue_program=false
        elif [ "$input" == "H" ]; then
            if (($dealer_hand_value < 17)); then
                deal
                dealerDec+=($?)
            fi
            
            deal
            userDec+=($?)
        elif [ "$input" == "D" ]; then
            if (($dealer_hand_value < 17)); then
                deal
                dealerDec+=($?)
            fi
            deal
            userDec+=($?)
            let "wager*=2"
        fi

    fi

    if (($user_hand_value == 21)); then
        continue_program=true
        win_flag=true
        printf "Congratulations, you won!  Why not play again? \n\n"
    elif (($user_hand_value < 21)) && (($dealer_hand_value < 21)) && (($user_hand_value < $dealer_hand_value)); then
        let "wager*=1.5 | bc -1"
        continue_program=true
        win_flag=true
        printf "Congratulations, you won!  Why not play again? \n\n"
    elif (($user_hand_value < 21)) && (($dealer_hand_value)); then
        let "wager*=1.5 | bc -1"
        continue_program=true
        win_flag=true
        printf "Congratulations, you won!  Why not play again? \n\n"
    elif (($user_hand_value > 21)); then 
        continue_program=false
        win_flag=false
        printf "Drat!  I lost!  Play again and gimmie a chance to get even! \n"
    elif (($user_hand_value < 21)) && (($dealer_hand_value <= 21)) && (($dealer_hand_value < $user_hand_value)); then 
        continue_program=false
        win_flag=false
        printf "Drat!  I lost!  Play again and gimmie a chance to get even! \n"
    fi

done


# echo $input
