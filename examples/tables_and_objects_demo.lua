#!/usr/bin/env lua

--[[
Lua Tables and Objects Demonstration
====================================

This script demonstrates:
1. Basic tables and data structures
2. Metatables and metamethods
3. Object-oriented programming concepts
4. Classes and inheritance
5. Practical examples

Author: Lua Knowledge Base
Date: August 2025
]]--

print("=" .. string.rep("=", 60))
print("     LUA TABLES AND OBJECTS DEMONSTRATION")
print("=" .. string.rep("=", 60))

-- ============================================================================
-- SECTION 1: BASIC TABLES AND DATA STRUCTURES
-- ============================================================================

print("\n1. BASIC TABLES AND DATA STRUCTURES")
print("-" .. string.rep("-", 40))

-- Simple array-like table
local fruits = {"apple", "banana", "orange", "grape"}
print("Fruits array:")
for i, fruit in ipairs(fruits) do
    print("  " .. i .. ": " .. fruit)
end

-- Hash-like table (dictionary)
local person = {
    name = "John",
    age = 30,
    city = "New York",
    occupation = "Developer"
}

print("\nPerson hash table:")
for key, value in pairs(person) do
    print("  " .. key .. ": " .. value)
end

-- Mixed table (both array and hash)
local mixed = {
    "first",           -- index 1
    "second",          -- index 2
    name = "Mixed Table",
    count = 2
}

print("\nMixed table:")
print("  Array part: " .. mixed[1] .. ", " .. mixed[2])
print("  Hash part: name=" .. mixed.name .. ", count=" .. mixed.count)

-- Nested tables
local company = {
    name = "Tech Corp",
    employees = {
        {name = "Alice", role = "Manager"},
        {name = "Bob", role = "Developer"},
        {name = "Carol", role = "Designer"}
    },
    location = {
        city = "San Francisco",
        country = "USA"
    }
}

print("\nNested table structure:")
print("  Company: " .. company.name)
print("  Location: " .. company.location.city .. ", " .. company.location.country)
print("  Employees:")
for i, emp in ipairs(company.employees) do
    print("    " .. emp.name .. " - " .. emp.role)
end

-- ============================================================================
-- SECTION 2: METATABLES AND METAMETHODS
-- ============================================================================

print("\n\n2. METATABLES AND METAMETHODS")
print("-" .. string.rep("-", 40))

-- Vector class using metatables
local Vector = {}
Vector.__index = Vector

-- Constructor
function Vector.new(x, y)
    local v = {x = x or 0, y = y or 0}
    setmetatable(v, Vector)
    return v
end

-- Metamethod for addition
function Vector.__add(a, b)
    return Vector.new(a.x + b.x, a.y + b.y)
end

-- Metamethod for subtraction
function Vector.__sub(a, b)
    return Vector.new(a.x - b.x, a.y - b.y)
end

-- Metamethod for multiplication (scalar)
function Vector.__mul(a, b)
    if type(a) == "number" then
        return Vector.new(a * b.x, a * b.y)
    else
        return Vector.new(a.x * b, a.y * b)
    end
end

-- Metamethod for string representation
function Vector.__tostring(v)
    return "Vector(" .. v.x .. ", " .. v.y .. ")"
end

-- Metamethod for equality
function Vector.__eq(a, b)
    return a.x == b.x and a.y == b.y
end

-- Instance methods
function Vector:magnitude()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector:normalize()
    local mag = self:magnitude()
    if mag > 0 then
        return Vector.new(self.x / mag, self.y / mag)
    end
    return Vector.new(0, 0)
end

-- Demonstrate Vector operations
local v1 = Vector.new(3, 4)
local v2 = Vector.new(1, 2)

print("Vector demonstrations:")
print("  v1 = " .. tostring(v1))
print("  v2 = " .. tostring(v2))
print("  v1 + v2 = " .. tostring(v1 + v2))
print("  v1 - v2 = " .. tostring(v1 - v2))
print("  2 * v1 = " .. tostring(2 * v1))
print("  |v1| = " .. v1:magnitude())
print("  v1 normalized = " .. tostring(v1:normalize()))
print("  v1 == v2: " .. tostring(v1 == v2))

-- ============================================================================
-- SECTION 3: CLASSES AND OBJECT-ORIENTED PROGRAMMING
-- ============================================================================

print("\n\n3. CLASSES AND OBJECT-ORIENTED PROGRAMMING")
print("-" .. string.rep("-", 50))

-- Animal base class
local Animal = {}
Animal.__index = Animal

function Animal.new(name, species)
    local self = {
        name = name or "Unknown",
        species = species or "Unknown",
        energy = 100
    }
    setmetatable(self, Animal)
    return self
end

function Animal:speak()
    return self.name .. " makes a sound"
end

function Animal:eat(food)
    self.energy = math.min(100, self.energy + 10)
    return self.name .. " eats " .. food .. " (energy: " .. self.energy .. ")"
end

function Animal:sleep()
    self.energy = math.min(100, self.energy + 20)
    return self.name .. " sleeps (energy: " .. self.energy .. ")"
end

function Animal:getInfo()
    return string.format("%s is a %s with %d energy", 
                        self.name, self.species, self.energy)
end

-- Dog class (inherits from Animal)
local Dog = {}
Dog.__index = Dog
setmetatable(Dog, Animal) -- Inheritance

function Dog.new(name, breed)
    local self = Animal.new(name, "Dog")
    self.breed = breed or "Mixed"
    self.loyalty = 100
    setmetatable(self, Dog)
    return self
end

function Dog:speak()
    return self.name .. " barks: Woof! Woof!"
end

function Dog:fetch()
    self.energy = math.max(0, self.energy - 5)
    self.loyalty = math.min(100, self.loyalty + 5)
    return self.name .. " fetches the ball (energy: " .. self.energy .. ", loyalty: " .. self.loyalty .. ")"
end

function Dog:wagTail()
    return self.name .. " wags tail happily!"
end

-- Cat class (inherits from Animal)
local Cat = {}
Cat.__index = Cat
setmetatable(Cat, Animal) -- Inheritance

function Cat.new(name, color)
    local self = Animal.new(name, "Cat")
    self.color = color or "Unknown"
    self.independence = 80
    setmetatable(self, Cat)
    return self
end

function Cat:speak()
    return self.name .. " meows: Meow!"
end

function Cat:purr()
    self.energy = math.min(100, self.energy + 5)
    return self.name .. " purrs contentedly (energy: " .. self.energy .. ")"
end

function Cat:hunt()
    self.energy = math.max(0, self.energy - 10)
    self.independence = math.min(100, self.independence + 3)
    return self.name .. " goes hunting (energy: " .. self.energy .. ", independence: " .. self.independence .. ")"
end

-- Demonstrate inheritance and polymorphism
local animals = {
    Animal.new("Generic", "Animal"),
    Dog.new("Buddy", "Golden Retriever"),
    Cat.new("Whiskers", "Orange Tabby")
}

print("Animal demonstrations:")
for i, animal in ipairs(animals) do
    print("\n  Animal " .. i .. ":")
    print("    " .. animal:getInfo())
    print("    " .. animal:speak())
    print("    " .. animal:eat("food"))
    
    -- Polymorphic behavior
    if animal.fetch then
        print("    " .. animal:fetch())
    end
    if animal.purr then
        print("    " .. animal:purr())
    end
end

-- ============================================================================
-- SECTION 4: ADVANCED METATABLE FEATURES
-- ============================================================================

print("\n\n4. ADVANCED METATABLE FEATURES")
print("-" .. string.rep("-", 40))

-- Smart table with automatic property tracking
local SmartTable = {}
SmartTable.__index = SmartTable

function SmartTable.new()
    local self = {
        _data = {},
        _history = {}
    }
    setmetatable(self, SmartTable)
    return self
end

-- Metamethod for indexing (getting values)
function SmartTable:__index(key)
    if key:sub(1, 1) == "_" then
        return rawget(self, key) -- Allow access to private fields
    end
    return SmartTable[key] or self._data[key]
end

-- Metamethod for setting values
function SmartTable:__newindex(key, value)
    if key:sub(1, 1) == "_" then
        rawset(self, key, value) -- Allow setting private fields
        return
    end
    
    local old_value = self._data[key]
    self._data[key] = value
    
    -- Track history
    table.insert(self._history, {
        key = key,
        old_value = old_value,
        new_value = value,
        timestamp = os.time()
    })
end

function SmartTable:getHistory()
    return self._history
end

function SmartTable:revert(steps)
    steps = steps or 1
    for i = 1, steps do
        local last = table.remove(self._history)
        if last then
            self._data[last.key] = last.old_value
        end
    end
end

-- Demonstrate SmartTable
local smart = SmartTable.new()
smart.name = "John"
smart.age = 25
smart.age = 26
smart.city = "New York"

print("SmartTable demonstration:")
print("  Current data:")
for k, v in pairs(smart._data) do
    print("    " .. k .. ": " .. tostring(v))
end

print("  History:")
for i, change in ipairs(smart:getHistory()) do
    print("    " .. i .. ". " .. change.key .. ": " .. 
          tostring(change.old_value) .. " -> " .. tostring(change.new_value))
end

smart:revert(1)
print("  After reverting 1 step, age = " .. smart.age)

-- ============================================================================
-- SECTION 5: PRACTICAL EXAMPLE - SIMPLE GAME CHARACTER SYSTEM
-- ============================================================================

print("\n\n5. PRACTICAL EXAMPLE - GAME CHARACTER SYSTEM")
print("-" .. string.rep("-", 50))

-- Base Character class
local Character = {}
Character.__index = Character

function Character.new(name, health, attack)
    local self = {
        name = name or "Unknown",
        health = health or 100,
        maxHealth = health or 100,
        attack = attack or 10,
        level = 1,
        experience = 0
    }
    setmetatable(self, Character)
    return self
end

function Character:takeDamage(damage)
    self.health = math.max(0, self.health - damage)
    return self.health > 0
end

function Character:heal(amount)
    self.health = math.min(self.maxHealth, self.health + amount)
end

function Character:gainExperience(exp)
    self.experience = self.experience + exp
    if self.experience >= self.level * 100 then
        self:levelUp()
    end
end

function Character:levelUp()
    self.level = self.level + 1
    self.maxHealth = self.maxHealth + 20
    self.health = self.maxHealth
    self.attack = self.attack + 5
    print("    " .. self.name .. " leveled up to level " .. self.level .. "!")
end

function Character:getStatus()
    return string.format("%s (Level %d): %d/%d HP, %d ATK, %d EXP", 
                        self.name, self.level, math.floor(self.health), self.maxHealth, 
                        math.floor(self.attack), self.experience)
end

-- Warrior class
local Warrior = {}
Warrior.__index = Warrior
setmetatable(Warrior, Character)

function Warrior.new(name)
    local self = Character.new(name, 120, 15)
    self.armor = 5
    setmetatable(self, Warrior)
    return self
end

function Warrior:takeDamage(damage)
    local reducedDamage = math.max(1, damage - self.armor)
    return Character.takeDamage(self, reducedDamage)
end

function Warrior:charge()
    return math.floor(self.attack * 1.5)
end

-- Mage class
local Mage = {}
Mage.__index = Mage
setmetatable(Mage, Character)

function Mage.new(name)
    local self = Character.new(name, 80, 8)
    self.mana = 50
    self.maxMana = 50
    setmetatable(self, Mage)
    return self
end

function Mage:castSpell()
    if self.mana >= 10 then
        self.mana = self.mana - 10
        return math.floor(self.attack * 2)
    else
        return math.floor(self.attack * 0.5) -- Weak attack without mana
    end
end

function Mage:restoreMana(amount)
    self.mana = math.min(self.maxMana, self.mana + (amount or 20))
end

-- Game simulation
local warrior = Warrior.new("Conan")
local mage = Mage.new("Gandalf")

print("Game Character System:")
print("  Initial status:")
print("    " .. warrior:getStatus())
print("    " .. mage:getStatus() .. " (Mana: " .. mage.mana .. ")")

print("\n  Combat simulation:")
-- Warrior attacks mage
local damage = warrior:charge()
print("    " .. warrior.name .. " charges for " .. damage .. " damage!")
mage:takeDamage(damage)
print("    " .. mage:getStatus())

-- Mage casts spell on warrior
local spellDamage = mage:castSpell()
print("    " .. mage.name .. " casts spell for " .. spellDamage .. " damage!")
warrior:takeDamage(spellDamage)
print("    " .. warrior:getStatus())

-- Gain experience and level up
warrior:gainExperience(150)
mage:gainExperience(120)

print("\n  Final status:")
print("    " .. warrior:getStatus())
print("    " .. mage:getStatus() .. " (Mana: " .. mage.mana .. ")")

-- ============================================================================
-- CONCLUSION
-- ============================================================================

print("\n\n" .. "=" .. string.rep("=", 60))
print("                    DEMONSTRATION COMPLETE")
print("=" .. string.rep("=", 60))
print("\nThis script demonstrated:")
print("• Basic tables (arrays, hashes, mixed, nested)")
print("• Metatables and metamethods (__add, __sub, __mul, __tostring, etc.)")
print("• Object-oriented programming with classes")
print("• Inheritance using metatables")
print("• Polymorphism and method overriding")
print("• Advanced metatable features (__index, __newindex)")
print("• Practical game character system example")
print("\nKey concepts learned:")
print("• Tables are Lua's main data structure")
print("• Metatables add behavior to tables")
print("• Classes can be implemented using tables and metatables")
print("• Inheritance is achieved through metatable chaining")
print("• Lua's flexibility allows many OOP patterns")
