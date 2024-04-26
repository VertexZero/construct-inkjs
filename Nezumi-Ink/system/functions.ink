//  Current Level/Dungeon
VAR CurrentLevel = ""

//  Levels
CONST LEVEL_01 = "Gwenindór Village"

// Inventory System
VAR Inventory = ()
VAR Keys      = ()
VAR Spells    = ()
VAR LampState = -1

CONST OFF = 0
CONST ON  = 1

LIST QuestItem  = strawberries, baking_pan, mithren_book, family_heirloom, oar_1, oar_2
LIST UniqueItem = magic_flute, familiar, lamp
LIST KeyItem    = copper_key, bronze_key, silver_key, gold_key

LIST Melodies = reveal, repair

// Copper heart-shaped key
// Bronze heart-shaped key
// Silver diamond-shaped key
// Gold skull-shaped key


// Locations/Scenes visited
VAR Visited = ()

//  List Level Locations
LIST level01 = forge, shop, library, shrine  // Level 1

// Booleans
CONST True  = true
CONST False = false

// Quest System
VAR Quest_001 = QUEST_UNSTARTED   // Birthday’s Cake             - Return to Home with strawberries, baking_pan
VAR Quest_002 = QUEST_UNSTARTED   // Mithren’s Book              - Return to Forge with mithren_book
VAR Quest_003 = QUEST_UNSTARTED   // Restore the Balance         - Complete the game
VAR Quest_004 = QUEST_UNSTARTED   // Family Heirloom             - Return to Old Cemetery with family_heirloom
VAR Quest_005 = QUEST_UNSTARTED   // With Both Oars in the Water - Return to Stranded Boat with oar_1 and oar_2

CONST QUEST_UNSTARTED = "quest_unstarted"
CONST QUEST_ACTIVE    = "quest_active"
CONST QUEST_COMPLETE  = "quest_complete"
CONST QUEST_DECLINED  = "quest_declined"

//  Multiple choices tracker
VAR SelectedChoices = 0

//  Who is currently speaking?
VAR CurrentSpeaker = ""

LIST Actors = (none), BLACKSMITH, CUSTOMER, SHOPKEEPER, SHOPHELPER, BOOKKEEPER, DRIFTER, SAGEOWL, HUSBAND, BARD

//  Knowledge
VAR Knowledge = ()

// List Level Locations Knowledge 
/*------------------------------------------------------------------------------------------------------
LEVEL-1 LOCATIONS
    1. Home - Bedroom
    2. Home - Kitchen (Day)
    3. Forge 
    4. Shop 
    5. Library
    6. Shrine
    7. Home - Kitchen (Evening)
    8. Home - Living-Room
    9. Home - Kitchen (Next Day)
------------------------------------------------------------------------------------------------------*/
LIST level01scn00 = (nothing), tidied_room   // Level 1 - Home Bedroom
LIST level01scn01 = (nothing), mithren_book  // Level 1 - Forge
LIST level01scn02 = (nothing), give_away     // Level 2 - Shop
LIST level01scn03 = (nothing), books         // Level 2 - Library




/*------------------------------------------------------------------------------------------------------
DUNGEON 01 LAYOUT
- FLOOR 01
    1.  Entrance 
    2.  Forge 
    3.  Cellar 
    4.  Stairs 
    5.  Kitchen 
    6.  Storage 
- FLOOR 02
    7.  Entrance 
    8.  Library 
    9.  Observatory 
    10. Skull Gate 
    11. Encounter 
    12. Court Hall
------------------------------------------------------------------------------------------------------*/


//  Used to check order of elements.
VAR Order = ()

LIST Pans = (none), small, medium, large

//  Various
VAR ExternalText = ""
VAR Coins        = 0

VAR UseWith = ()

VAR returnTo = ""      // Where to return to (knot)
VAR continueOnto = ""  // Where to continue (knot)


/*  ------------------------------------------------------------------------------------------------------ */
/*  GAME SYTEM */
//  Learn facts from the game world.
==  function Learn(ref facts, x)
    ~ facts += x
    
//  Did you learn this particular fact for this room?
==  function DidLearn(ref facts, x)
    ~ return facts ? x    
    
//  You haven't learnt this particular fact.
==  function DidNotLearn(ref facts, x)
    ~ return facts !? x  
    
==  function HasVisited(x)
    { 
        - Visited !? x:
            ~ Visited += x
    }
    
==  function GetItem(ref typeOf, item)
    ~ typeOf += item  
    
==  function UseItem(ref typeOf, item)
    ~ typeOf -= item   
    
==  function HasItem(ref typeOf, item)
    ~ return typeOf ? item    
    
==  function SetQuestState(ref quest, state)
    ~ quest = state
    
==  function ResetSelectedChoices()
    ~ SelectedChoices = 0
    
==  function CurrentActor(x)
    ~ CurrentSpeaker = x
    
==  function Speaker()
    [b]
    ~ return CurrentSpeaker 
    
//	Tunnels as threads.
==  tunnel_as_thread(-> tunnel, -> ret )
-   (top)
    -> tunnel ->
    {TURNS_SINCE(-> top) == 0: -> DONE }  -> ret 
    
==  function Add( ref x, k )
	~ x = x + k

==  function Substract(ref x, k)
	~ x = x - k
	
==  function AddToUseWith(obj) 
    ~ UseWith += obj

==  function ResetUseWith()
    ~ UseWith = ()
	
==  function IsUsing(x)
    ~ return UseWith ? x   





    
