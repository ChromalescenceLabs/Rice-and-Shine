# TEAM JOURNALS
A culmination of journals for the ThirdSpace team that worked on this project.

## WEEK 1: SEPTEMBER 13-20
### 1. ALLIUMC
Things I've did:
1. draw temporary assets
2. did the peeler
- peeled the the potatoes
- win condition
3. did the the grater
- pick up the potato 
- grater
 - enter area of grater (did not finish)
  - basically each time u grate u hide the first 2 children then make visible the next 2
 - win condition after the grated potatoes done cycling through all its children (did not finish)

**My thoughts on the matter:**
I didn't have much time to code for the game since school was taking up too much of my time and I was also struggling since I haven't coded in godot fot a hot while. I forgot how to do most of the stuff so I played around with the scenes for a bit. I didn't have enough time to search around since I was cramming for the hours so most of my stuff remains unfinished. 

**The Things I had Trouble with:**
1. the win condition for the peeler
- So this is the feature that had taken most of my time. I try to do various stuff like:
 - try to check if the whole unpeeled image is inside the collision of the peeled images
 - try to make a collision shape out of the line2d polyline and check if all the points in the line2d polyline is inside the collision shape of the peeled images
2. my laptop keeps lagging out whenever I'm testing
3. I keep frequently switching tasks
- I had a hard time focusing on a single task since it was getting late into the night

**Additional Notes**

Most of my commit messages have its vital information in their descriptions. I also briefly worked on certain assets.

### 2. CLIF
Progress:
Made a selection screen for minigames
- Eh, simple stuff, the initial screen I did, I just eyeballed the center. then when I changed the buttons from well, buttons into textured buttons, I finally used math to position it and not eyeball them. also I guess this is the very first thing I did in Godot and to the project.

Made the pancake cooking minigame (cooking part)
- Was initially planning to add the batter making process along with it, but I just focused on the cooking of it. I put 4 scenes into 1 scene, which was the oil, measuring cup, batter bowl, and the pan. Which made it easy to manage, I just needed the 'big' scene to load the 4 on ready. The code for the oil and measuring cup are somewhat similar. Same goes for pan and bowl.
- Initially, I tried to implement 2 collision areas for the pan, so that the measuring cup and oil interacts with collision#1 and the mouse clicks can only intereact with collision#2, but I couldnt figure it out, so I just reverted it back into 1.

Drew some permanent (?) assets and temporary assets
- For this, I drew them using Krita, I ~~Stole~~, Requested for [@RaphlTicket](https://github.com/RaphlTicket)'s brush on Krita and tried to adapt his style of drawing. which, I guess turned out good (According to the others). Which led me to draw some assets that were meant to be placeholder but I guess i got carried away. Funny thing is, when I was trying to draw the bowl, it looked like a plate, so I just made it a plate then changed the way the shading was and became a bowl. so now theres a stray unused plate in the assets. Will probably be used in the future.

### 3. JAZZ
I spent all of my time coding:
- I imported the Dialogue System addon by Nathan Hoad for future usage in our project; and also quickly made the loading screen for changing between scenes.
- I added the initial functionality for the recipe book on the bottom left; it's not finished and implemented across the minigames yet since I want to flesh out its system next week.
- I mainly coded the rice minigame; which took a lot of systems working together:
  - This included the dragging mechanic, where I used lerp for the first time (surprisingly)
  - A bit of initial code for the progress bars when it comes to filling up the bowl with water and the time it takes for the rice to cook.
- Other than the rice, I also managed to implement the initial pop up when you complete an action successfully (which I implemented across everyone's minigames). Both this and the water in the rice minigame got me learning about particles, which I find interesting and might improve within the next following weeks.
- Also mainly managed the repository and the initial Itch page, which will be updated in the following weeks.

- Overall, I'd say I'm happy with the progress I got. I'll be sure to improve the initial codes I've written within the next following weeks.

### 4. JEANKAMAGALING
I divided my time as follows; 5 hours spent on art and 5 hours spent on coding.
- For art, I mainly worked on the game's logo/banner, and also created some placeholder sprites for certain minigames.
- I also worked on the placeholder art for the background of the main cooking scenes.
Then from September 19-20, I began coding for thirdspace.
- I first worked on our game's main menu by adding the background for the main menu, and making the layout for the buttons and then made a new scene for the options menu. 
- I then added animations to the buttons for the main menu and options menu, and made the background parallax. I struggled with doing this part at first but I was able to figure it out eventually. Afterwards, I put a Fullscreen toggle for the options menu and added the logo on the main menu screen.
- I then made a mode select screen so that players could choose between playing freeplay mode or story mode, however story mode isn't done yet. Only freeplay is functional for now.
- I then went back and added audio sliders for the options menu. At first they didn't work but after some tweaking, I got it to be functional. I added a music manager so that music can be continuously play across different scenes, and made a custom cursor which could be used in the future.
- With my remaining time, I decided to polish some parts of the main menu, and options menu before my ten hours were up.
