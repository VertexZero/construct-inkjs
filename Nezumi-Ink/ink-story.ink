// System
INCLUDE system/functions.ink
INCLUDE system/external_functions.ink
// Levels
INCLUDE levels/level_1.ink



//  Game Inventory
=== ItemInventory
+   {Inventory ? QuestItem.baking_pan} [Baking-Pan]
    ~ AddToUseWith(QuestItem.baking_pan)
    -> continueOnto
    
+   {Inventory ? QuestItem.strawberries} [Strawberries]
    ~ AddToUseWith(QuestItem.strawberries)
    -> continueOnto
    
+   {Inventory ? QuestItem.mithren_book} [Mithren's Book]
    ~ AddToUseWith(QuestItem.mithren_book)
    -> continueOnto
    
+   {Spells ? Melodies.reveal} [Magic Flute (Reveal)]
    ~ AddToUseWith(Melodies.reveal)
    -> continueOnto
    
+   {HasItem(Inventory, QuestItem.family_heirloom)} [Family Heirloom]
    ~ AddToUseWith(QuestItem.family_heirloom)
    -> continueOnto
    
+   {HasItem(Inventory, UniqueItem.lamp)} [Lamp]
    ~ AddToUseWith(UniqueItem.lamp)
    -> continueOnto
    
    /* If there's no other choice availbale, we default to 'Nothing to USE'. */    
+   {CHOICE_COUNT() == 0} [(Nothing to USE)] 
    -> returnTo
    

 