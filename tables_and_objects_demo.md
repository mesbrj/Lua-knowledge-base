# Lua Examples

This folder contains practical examples demonstrating various Lua concepts and features.

## Files

### `tables_and_objects_demo.lua`

A comprehensive demonstration script that covers:

1. **Basic Tables and Data Structures**
   - Array-like tables
   - Hash tables (dictionaries)
   - Mixed tables
   - Nested table structures

2. **Metatables and Metamethods**
   - Vector class with mathematical operations
   - `__add`, `__sub`, `__mul`, `__tostring`, `__eq` metamethods
   - Custom behavior for table operations

3. **Object-Oriented Programming**
   - Class creation using tables and metatables
   - Constructor functions
   - Instance methods
   - Encapsulation concepts

4. **Inheritance**
   - Base class (Animal) with common functionality
   - Derived classes (Dog, Cat) with specialized behavior
   - Method overriding and polymorphism

5. **Advanced Metatable Features**
   - Smart table with property tracking
   - `__index` and `__newindex` metamethods
   - History tracking and rollback functionality

6. **Practical Example**
   - Game character system
   - Character classes with different abilities
   - Combat simulation
   - Experience and leveling system

## Running the Examples

To run the main demonstration:

```bash
lua tables_and_objects_demo.lua
```

Or make it executable and run directly:

```bash
chmod +x tables_and_objects_demo.lua
./tables_and_objects_demo.lua
```

## Learning Objectives

After studying these examples, you should understand:

- How Lua tables work as the primary data structure
- How to use metatables to add custom behavior
- How to implement object-oriented programming patterns
- How to create classes and inheritance hierarchies
- How to use metamethods for operator overloading
- Practical applications of these concepts in real projects

## References

- [Programming in Lua - Tables](https://www.lua.org/pil/11.html)
- [Programming in Lua - Metatables and Metamethods](https://www.lua.org/pil/13.html)
- [Programming in Lua - Object-Oriented Programming](https://www.lua.org/pil/16.html)
