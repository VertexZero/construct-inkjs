
//  Location: Gwenindór Village
=== Level01

=   exterior
//  Gwenindór Village - Main (Exterior)
->  DONE

=   scn_forge
//  FORGE
//  NPC: Mithren, the Blacksmith
-   (bit01)
    // Tag
    # HELLO_WORLD
    # SHOW_ACTOR  
    // External function
    ~ PlayBGM("bgm")
    ~ CurrentActor(BLACKSMITH)
    { Visited !? level01.forge: The door is ajar, and you enter. Inside, a tall grey figure is standing near a forge hearth, smiling. }
    { Visited ? level01.forge:  You push the door gently and enter. Inside, a familiar face is smiling at you. }

-   (bit02)
//  RICH-CARD CAROUSEL
+    { Knowledge !? level01scn01.mithren_book } [Overhear Conversation] -> Level01.scn_forge.overhear_conversation 
+   [Continue to Dialog]                                                -> Level01.scn_forge.bit03

-   (bit03)
//  We switch the initial dialogue line depending on whether Nezumi has previously visited the Forge.
    { Visited !? level01.forge: {Speaker()}[/b]: Hey Nezumi, how may I help ya! }
    { Visited ? level01.forge:  {Speaker()}[/b]: Welcome back, kiddo! }
    
    ~ HasVisited(level01.forge)
    -> Level01.scn_forge.ret

-   (bit04)
    {Speaker()}[/b]: Anything else, kiddo?
-   (ret) <- tunnel_as_thread(-> dialog, -> Level01.scn_forge.bit04) 
->  DONE


//  ON-SCREEN DIALOG SELECTION
-   (dialog)
    ~ continueOnto = -> Level01.scn_forge.scene_objects
    ~ returnTo     = -> Level01.scn_forge.bit04
    ~ ResetUseWith()
*   [What's your name?]                                           -> Level01.scn_forge.ask_name
*   [What do you do?]                                             -> Level01.scn_forge.ask_occupation
*   {Knowledge ? level01scn01.mithren_book} [I can get your book] -> Level01.scn_forge.offer_help
*   {Inventory !? QuestItem.strawberries}   [I need strawberries] -> Level01.scn_forge.need_strawberries
+   [I should leave]                                              -> Level01.scn_forge.leave
-   (done) ->->


//  SCENE OBJECTS
//  Whenever an object is selected in a scene, we need to pass the data from UNITY to Ink using External functions.
-   (scene_objects)
+   [Mithren, the Blacksmith]
    ~ AddToUseWith(Actors.BLACKSMITH)
    -> Level01.scn_forge._npc  
    
+   [(CANCEL)] 
    -> Level01.scn_forge.bit04
    
    
//  FORGE EVENTS
//  1. NPC 
-   (_npc)
    /* Use Baking-Pan */
    {IsUsing(QuestItem.baking_pan) && IsUsing(Actors.BLACKSMITH):
        {Speaker()}[/b]: {~ Is there something wrong with the baking-pan? | Huh? | I don't have a bag, sorry. | No refunds, kiddo. Sorry! }
        The blacksmith seems confused.
        -> Level01.scn_forge.bit04
    }
    /* Use Strawberries */
    {IsUsing(QuestItem.strawberries) && IsUsing(Actors.BLACKSMITH):
        {Speaker()}[/b]: {~ Thanks, I'm not hungry! | Aren't you supposed to bring back those home? }
        The blacksmith seems confused.
        -> Level01.scn_forge.bit04
    }
    /* Use Mithren's Book */
    {IsUsing(QuestItem.mithren_book) && IsUsing(Actors.BLACKSMITH):
        ~ UseItem(Inventory, QuestItem.mithren_book)
        ~ SetQuestState(Quest_002, QUEST_COMPLETE)
        
        {Speaker()}[/b]: Ah great, thanks! I've been waiting for this book for some time.
        -> Level01.scn_forge.quest_complete
    }
    -> DONE

//  2.     
-   (quest_complete)
+   [What's this book about?]
    {Speaker()}[/b]: Oh, well... It's about this old powerful magician and a small group of little ones who save the world!
    You smile, daydreaming about all those adventures.
    -> Level01.scn_forge.bit04
            
+   [No problem!]
    -> Level01.scn_forge.bit04
        
//  3.
-   (overhear_conversation)
    ~ CurrentActor(CUSTOMER)
    {Speaker()}[/b]: Have you received that [b]book[/b] you've been talking about yet?
*   [Continue] ->
-   ~ CurrentActor(BLACKSMITH)
    ~ Learn(Knowledge, level01scn01.mithren_book)
    {Speaker()}[/b]: Oh, no, not yet... Sadly, I have been too busy to go get it at the [b]Library[/b].
    
*   [Continue]
    -> Level01.scn_forge.bit03

//  4.
-   (ask_name)
    {Speaker()}[/b]: Oh, I suppose you forgot. My name is [b]Mithren[/b] the grey.
    -> Level01.scn_forge.bit04

//  5.
-   (ask_occupation)
    {Speaker()}[/b]: Well, I'm a blacksmith! I forge iron tools of all types.
*   [Interesting!] 
    The blacksmith appears delighted.              
    -> Level01.scn_forge.bit04
    
*   [Oh, ok]       
    The blacksmith stares at you, a tad perplexed.
    -> Level01.scn_forge.bit04

//  6.
-   (need_strawberries)
    {Speaker()}[/b]: Strawberries?! You ain't gonna find that here, little one. 
    {Speaker()}[/b]: You should visit the [b]Shopkeeper[/b] — I'm sure she has strawberries to sell. 
    -> Level01.scn_forge.bit04

//  7.    
-   (offer_help)
    ~ SetQuestState(Quest_002, QUEST_ACTIVE)
    
    {Speaker()}[/b]: Really? Thank you! You will have to go visit the [b]Bookkeeper[/b].
    You nod, happy to help.
    -> Level01.scn_forge.bit04

//  8.    
-   (leave)
    You bow and politely bid farewell.
    
    {Speaker()}[/b]: Have a nice day, Nezumi! 
    And soon after, the blacksmith returned to his chores while whistling a cheerful melody.
    {Inventory ? QuestItem.strawberries && Inventory ? QuestItem.baking_pan:
        ~ SetQuestState(Quest_001, QUEST_COMPLETE)
    }
    -> Level01.exterior
    
//  ---------------------------------------------------------  END  
