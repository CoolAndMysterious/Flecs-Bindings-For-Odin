// Comment out this line when using as DLL
package flecs
foreign import lib "flecs_static.lib"

import "core:c"
import "core:c/libc"

/**
* @defgroup c C API
*
* @{
* @}
*/

/**
* @defgroup core Core
* @ingroup c
* Core ECS functionality (entities, storage, queries).
*
* @{
*/

/**
* @defgroup options API defines
* Defines for customizing compile-time features.
*
* @{
*/

/* Flecs version macros */
FLECS_VERSION_MAJOR    :: 4  /**< Flecs major version. */
FLECS_VERSION_MINOR    :: 1  /**< Flecs minor version. */
FLECS_VERSION_PATCH    :: 6  /**< Flecs patch version. */
FLECS_HI_COMPONENT_ID  :: 256
FLECS_HI_ID_RECORD_ID  :: 1024
FLECS_SPARSE_PAGE_BITS :: 6
FLECS_ENTITY_PAGE_BITS :: 10
FLECS_ID_DESC_MAX      :: 32
FLECS_EVENT_DESC_MAX   :: 8

/** @def FLECS_VARIABLE_COUNT_MAX
* Maximum number of query variables per query. */
FLECS_VARIABLE_COUNT_MAX       :: 64
FLECS_TERM_COUNT_MAX           :: 32
FLECS_TERM_ARG_COUNT_MAX       :: 16
FLECS_QUERY_VARIABLE_COUNT_MAX :: 64
FLECS_QUERY_SCOPE_NESTING_MAX  :: 8
FLECS_DAG_DEPTH_MAX            :: 128

/** @def FLECS_TREE_SPAWNER_DEPTH_CACHE_SIZE
* Size of the depth cache in the tree spawner component. Higher values speed up prefab
* instantiation for deeper hierarchies, at the cost of slightly more memory.
*/
FLECS_TREE_SPAWNER_DEPTH_CACHE_SIZE :: (6)

////////////////////////////////////////////////////////////////////////////////
//// World flags
////////////////////////////////////////////////////////////////////////////////
EcsWorldQuitWorkers           :: (1<<0)
EcsWorldReadonly              :: (1<<1)
EcsWorldInit                  :: (1<<2)
EcsWorldQuit                  :: (1<<3)
EcsWorldFini                  :: (1<<4)
EcsWorldMeasureFrameTime      :: (1<<5)
EcsWorldMeasureSystemTime     :: (1<<6)
EcsWorldMultiThreaded         :: (1<<7)
EcsWorldFrameInProgress       :: (1<<8)

////////////////////////////////////////////////////////////////////////////////
//// OS API flags
////////////////////////////////////////////////////////////////////////////////
EcsOsApiHighResolutionTimer   :: (1<<0)
EcsOsApiLogWithColors         :: (1<<1)
EcsOsApiLogWithTimeStamp      :: (1<<2)
EcsOsApiLogWithTimeDelta      :: (1<<3)

////////////////////////////////////////////////////////////////////////////////
//// Entity flags (set in upper bits of ecs_record_t::row)
////////////////////////////////////////////////////////////////////////////////
EcsEntityIsId                 :: (1<<31)
EcsEntityIsTarget             :: (1<<30)
EcsEntityIsTraversable        :: (1<<29)
EcsEntityHasDontFragment      :: (1<<28)

////////////////////////////////////////////////////////////////////////////////
//// ID flags (used by ecs_component_record_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsIdOnDeleteRemove            :: (1<<0)
EcsIdOnDeleteDelete            :: (1<<1)
EcsIdOnDeletePanic             :: (1<<2)
EcsIdOnDeleteMask             :: (EcsIdOnDeletePanic|EcsIdOnDeleteRemove|EcsIdOnDeleteDelete)
EcsIdOnDeleteTargetRemove      :: (1<<3)
EcsIdOnDeleteTargetDelete      :: (1<<4)
EcsIdOnDeleteTargetPanic       :: (1<<5)
EcsIdOnDeleteTargetMask       :: (EcsIdOnDeleteTargetPanic|EcsIdOnDeleteTargetRemove|EcsIdOnDeleteTargetDelete)
EcsIdOnInstantiateOverride     :: (1<<6)
EcsIdOnInstantiateInherit      :: (1<<7)
EcsIdOnInstantiateDontInherit  :: (1<<8)
EcsIdOnInstantiateMask        :: (EcsIdOnInstantiateOverride|EcsIdOnInstantiateInherit|EcsIdOnInstantiateDontInherit)
EcsIdExclusive                 :: (1<<9)
EcsIdTraversable               :: (1<<10)
EcsIdPairIsTag                 :: (1<<11)
EcsIdWith                      :: (1<<12)
EcsIdCanToggle                 :: (1<<13)
EcsIdIsTransitive              :: (1<<14)
EcsIdInheritable               :: (1<<15)
EcsIdHasOnAdd                  :: (1<<16) /* Same values as table flags. */
EcsIdHasOnRemove               :: (1<<17)
EcsIdHasOnSet                  :: (1<<18)
EcsIdHasOnTableCreate          :: (1<<19)
EcsIdHasOnTableDelete          :: (1<<20)
EcsIdSparse                    :: (1<<21)
EcsIdDontFragment              :: (1<<22)
EcsIdMatchDontFragment         :: (1<<23) /* For (*, T) wildcards. */
EcsIdOrderedChildren           :: (1<<24)
EcsIdSingleton                 :: (1<<25)
EcsIdEventMask                :: (EcsIdHasOnAdd|EcsIdHasOnRemove|EcsIdHasOnSet|EcsIdHasOnTableCreate|EcsIdHasOnTableDelete|EcsIdSparse|EcsIdOrderedChildren)
EcsIdPrefabChildren            :: (1<<26)
EcsIdMarkedForDelete           :: (1<<30)

////////////////////////////////////////////////////////////////////////////////
//// Bits set in world->non_trivial array
////////////////////////////////////////////////////////////////////////////////
EcsNonTrivialIdSparse          :: (1<<0)
EcsNonTrivialIdNonFragmenting  :: (1<<1)
EcsNonTrivialIdInherit         :: (1<<2)

////////////////////////////////////////////////////////////////////////////////
//// Iterator flags (used by ecs_iter_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsIterIsValid                 :: (1<<0)  /* Does the iterator contain a valid result. */
EcsIterNoData                  :: (1<<1)  /* Does the iterator provide (component) data. */
EcsIterNoResults               :: (1<<2)  /* Iterator has no results. */
EcsIterMatchEmptyTables        :: (1<<3)  /* Match empty tables. */
EcsIterIgnoreThis              :: (1<<4)  /* Only evaluate non-this terms. */
EcsIterTrivialChangeDetection  :: (1<<5)
EcsIterHasCondSet              :: (1<<6)  /* Does the iterator have conditionally set fields. */
EcsIterProfile                 :: (1<<7)  /* Profile iterator performance. */
EcsIterTrivialSearch           :: (1<<8)  /* Trivial iterator mode. */
EcsIterTrivialTest             :: (1<<11) /* Trivial test mode (constrained $this). */
EcsIterTrivialCached           :: (1<<14) /* Trivial search for cached query. */
EcsIterCached                  :: (1<<15) /* Cached query. */
EcsIterFixedInChangeComputed   :: (1<<16) /* Change detection for fixed-in terms is done. */
EcsIterFixedInChanged          :: (1<<17) /* Fixed-in terms changed. */
EcsIterSkip                    :: (1<<18) /* Result was skipped for change detection. */
EcsIterCppEach                 :: (1<<19) /* Uses C++ 'each' iterator. */
EcsIterImmutableCacheData      :: (1<<21) /* Internally used by the engine to indicate immutable arrays from the cache. */

/* Same as event flags. */
EcsIterTableOnly               :: (1<<20)  /* Result only populates the table. */

////////////////////////////////////////////////////////////////////////////////
//// Event flags (used by ecs_event_desc_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsEventTableOnly              :: (1<<20) /* Table event (no data, same as iter flags). */
EcsEventNoOnSet                :: (1<<16) /* Don't emit OnSet for inherited IDs. */

////////////////////////////////////////////////////////////////////////////////
//// Query flags (used by ecs_query_t::flags)
////////////////////////////////////////////////////////////////////////////////

/* Flags that can only be set by the query implementation. */
EcsQueryMatchThis             :: (1<<11) /* Query has terms with $this source. */
EcsQueryMatchOnlyThis         :: (1<<12) /* Query only has terms with $this source. */
EcsQueryMatchOnlySelf         :: (1<<13) /* Query has no terms with up traversal. */
EcsQueryMatchWildcards        :: (1<<14) /* Query matches wildcards. */
EcsQueryMatchNothing          :: (1<<15) /* Query matches nothing. */
EcsQueryHasCondSet            :: (1<<16) /* Query has conditionally set fields. */
EcsQueryHasPred               :: (1<<17) /* Query has equality predicates. */
EcsQueryHasScopes             :: (1<<18) /* Query has query scopes. */
EcsQueryHasRefs               :: (1<<19) /* Query has terms with static source. */
EcsQueryHasOutTerms           :: (1<<20) /* Query has [out] terms. */
EcsQueryHasNonThisOutTerms    :: (1<<21) /* Query has [out] terms with no $this source. */
EcsQueryHasChangeDetection    :: (1<<22) /* Query has a monitor for change detection. */
EcsQueryIsTrivial             :: (1<<23) /* Query can use trivial evaluation function. */
EcsQueryHasCacheable          :: (1<<24) /* Query has cacheable terms. */
EcsQueryIsCacheable           :: (1<<25) /* All terms of the query are cacheable. */
EcsQueryHasTableThisVar       :: (1<<26) /* Does the query have $this table var. */
EcsQueryCacheYieldEmptyTables :: (1<<27) /* Does the query cache empty tables. */
EcsQueryTrivialCache          :: (1<<28) /* Trivial cache (no wildcards, traversal, order_by, group_by, change detection). */
EcsQueryNested                :: (1<<29) /* Query created by a query (for observer, cache). */
EcsQueryCacheWithFilter       :: (1<<30)
EcsQueryValid                 :: (1<<31)

////////////////////////////////////////////////////////////////////////////////
//// Term flags (used by ecs_term_t::flags_)
////////////////////////////////////////////////////////////////////////////////
EcsTermMatchAny               :: (1<<0)
EcsTermMatchAnySrc            :: (1<<1)
EcsTermTransitive             :: (1<<2)
EcsTermReflexive              :: (1<<3)
EcsTermIdInherited            :: (1<<4)
EcsTermIsTrivial              :: (1<<5)
EcsTermIsCacheable            :: (1<<6)
EcsTermIsScope                :: (1<<7)
EcsTermIsMember               :: (1<<8)
EcsTermIsToggle               :: (1<<9)
EcsTermIsSparse               :: (1<<10)
EcsTermIsOr                   :: (1<<11)
EcsTermDontFragment           :: (1<<12)
EcsTermNonFragmentingChildOf  :: (1<<13)

////////////////////////////////////////////////////////////////////////////////
//// Observer flags (used by ecs_observer_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsObserverMatchPrefab         :: (1<<1)  /* Same as query. */
EcsObserverMatchDisabled       :: (1<<2)  /* Same as query. */
EcsObserverIsMulti             :: (1<<3)  /* Does the observer have multiple terms. */
EcsObserverIsMonitor           :: (1<<4)  /* Is the observer a monitor. */
EcsObserverIsDisabled          :: (1<<5)  /* Is the observer entity disabled. */
EcsObserverIsParentDisabled    :: (1<<6)  /* Is the module parent of the observer disabled. */
EcsObserverBypassQuery         :: (1<<7)  /* Don't evaluate query for multi-component observer. */
EcsObserverYieldOnCreate       :: (1<<8)  /* Yield matching entities when creating observer. */
EcsObserverYieldOnDelete       :: (1<<9)  /* Yield matching entities when deleting observer. */
EcsObserverKeepAlive           :: (1<<11) /* Observer keeps component alive (same value as EcsTermKeepAlive). */

////////////////////////////////////////////////////////////////////////////////
//// Table flags (used by ecs_table_t::flags)
////////////////////////////////////////////////////////////////////////////////
EcsTableHasBuiltins            :: (1<<0)  /* Does the table have built-in components. */
EcsTableIsPrefab               :: (1<<1)  /* Does the table store prefabs. */
EcsTableHasIsA                 :: (1<<2)  /* Does the table have IsA relationship. */
EcsTableHasMultiIsA            :: (1<<3)  /* Does the table have multiple IsA pairs. */
EcsTableHasChildOf             :: (1<<4)  /* Does the table type have ChildOf relationship. */
EcsTableHasParent              :: (1<<5)  /* Does the table type have Parent component. */
EcsTableHasName                :: (1<<6)  /* Does the table type have (Identifier, Name). */
EcsTableHasPairs               :: (1<<7)  /* Does the table type have pairs. */
EcsTableHasModule              :: (1<<8)  /* Does the table have module data. */
EcsTableIsDisabled             :: (1<<9)  /* Does the table type have EcsDisabled. */
EcsTableNotQueryable           :: (1<<10)  /* Table should never be returned by queries. */
EcsTableHasCtors               :: (1<<11)
EcsTableHasDtors               :: (1<<12)
EcsTableHasCopy                :: (1<<13)
EcsTableHasMove                :: (1<<14)
EcsTableHasToggle              :: (1<<15)
EcsTableHasOnAdd               :: (1<<16) /* Same values as ID flags. */
EcsTableHasOnRemove            :: (1<<17)
EcsTableHasOnSet               :: (1<<18)
EcsTableHasOnTableCreate       :: (1<<19)
EcsTableHasOnTableDelete       :: (1<<20)
EcsTableHasSparse              :: (1<<21)
EcsTableHasDontFragment        :: (1<<22)
EcsTableOverrideDontFragment   :: (1<<23)
EcsTableHasOrderedChildren     :: (1<<24)
EcsTableHasOverrides           :: (1<<25)
EcsTableHasTraversable         :: (1<<27)
EcsTableEdgeReparent           :: (1<<28)
EcsTableMarkedForDelete        :: (1<<29)

/* Composite table flags */
EcsTableHasLifecycle     :: (EcsTableHasCtors|EcsTableHasDtors)
EcsTableIsComplex        :: (EcsTableHasLifecycle|EcsTableHasToggle|EcsTableHasSparse)
EcsTableHasAddActions    :: (EcsTableHasIsA|EcsTableHasCtors|EcsTableHasOnAdd|EcsTableHasOnSet)
EcsTableHasRemoveActions :: (EcsTableHasIsA|EcsTableHasDtors|EcsTableHasOnRemove)
EcsTableEdgeFlags        :: (EcsTableHasOnAdd|EcsTableHasOnRemove|EcsTableHasSparse)
EcsTableAddEdgeFlags     :: (EcsTableHasOnAdd|EcsTableHasSparse)
EcsTableRemoveEdgeFlags  :: (EcsTableHasOnRemove|EcsTableHasSparse|EcsTableHasOrderedChildren)

////////////////////////////////////////////////////////////////////////////////
//// Aperiodic action flags (used by ecs_run_aperiodic())
////////////////////////////////////////////////////////////////////////////////
EcsAperiodicComponentMonitors  :: (1<<2)  /* Process component monitors. */
EcsAperiodicEmptyQueries       :: (1<<4)  /* Process empty queries. */
ECS_CLANG_VERSION             :: 20

/* Utility types to indicate usage as a bitmask. */
ecs_flags8_t  :: u8
ecs_flags16_t :: u16
ecs_flags32_t :: u32
ecs_flags64_t :: u64

/* Keep unsigned integers out of the codebase as they do more harm than good. */
ecs_size_t :: i32

////////////////////////////////////////////////////////////////////////////////
//// Magic numbers for sanity checking
////////////////////////////////////////////////////////////////////////////////

/* Magic number to identify the type of the object. */
ecs_world_t_magic     :: (0x65637377)
ecs_stage_t_magic     :: (0x65637373)
ecs_query_t_magic     :: (0x65637375)
ecs_observer_t_magic  :: (0x65637362)

////////////////////////////////////////////////////////////////////////////////
//// Entity ID macros
////////////////////////////////////////////////////////////////////////////////
ECS_ROW_MASK        : u32 : 0x0FFFFFFF
ECS_ROW_FLAGS_MASK  : u32 : ~ECS_ROW_MASK

ECS_ID_FLAGS_MASK   : u64 : 0xFF << 56
ECS_ENTITY_MASK     : u64 : 0xFFFFFFFF
ECS_GENERATION_MASK : u64 : 0xFFFF << 32
ECS_COMPONENT_MASK  : u64 : ~ECS_ID_FLAGS_MASK

/** IDs are the things that can be added to an entity.
* An ID can be an entity or pair, and can have optional ID flags. */
ecs_id_t :: u64

/** An entity identifier.
* Entity IDs consist of a number unique to the entity in the lower 32 bits,
* and a counter used to track entity liveliness in the upper 32 bits. When an
* ID is recycled, its generation count is increased. This causes recycled IDs
* to be very large (>4 billion), which is normal. */
ecs_entity_t :: ecs_id_t

/** A type is a list of (component) IDs.
* Types are used to communicate the "type" of an entity. In most type systems, a
* typeof operation returns a single type. In ECS, however, an entity can have
* multiple components, which is why an ECS type consists of a vector of IDs.
*
* The component IDs of a type are sorted, which ensures that it doesn't matter
* in which order components are added to an entity. For example, if adding
* Position then Velocity would result in type [Position, Velocity], first
* adding Velocity then Position would also result in type [Position, Velocity].
*
* Entities are grouped together by type in the ECS storage in tables. The
* storage has exactly one table per unique type that is created by the
* application that stores all entities and components for that type. This is
* also referred to as an archetype.
*/
ecs_type_t :: struct {
	array: ^ecs_id_t, /**< Array with IDs. */
	count: i32,       /**< Number of elements in array. */
}

ecs_world_t            :: struct {}
ecs_stage_t            :: struct {}
ecs_table_t            :: struct {}
ecs_component_record_t :: struct {}

/** A poly object.
* A poly (short for polymorph) object is an object that has a variable list of
* capabilities, determined by a mixin table. This is the current list of types
* in the Flecs API that can be used as an ecs_poly_t:
*
* - ecs_world_t
* - ecs_stage_t
* - ecs_query_t
*
* Functions that accept an ecs_poly_t argument can accept objects of these
* types. If the object does not have the requested mixin, the API will throw an
* assert.
*
* The poly/mixin framework enables partially overlapping features to be
* implemented once, and enables objects of different types to interact with
* each other depending on what mixins they have, rather than their type
* (in some ways it's like a mini-ECS). Additionally, each poly object has a
* header that enables the API to do sanity checking on the input arguments.
*/
ecs_poly_t   :: struct {}
ecs_mixins_t :: struct {}

/** Header for ecs_poly_t objects. */
ecs_header_t :: struct {
	type:     i32,           /**< Magic number indicating which type of Flecs object. */
	refcount: i32,           /**< Refcount, to enable RAII handles. */
	mixins:   ^ecs_mixins_t, /**< Table with offsets to (optional) mixins. */
}

/** A component column. */
ecs_vec_t :: struct {
	array: rawptr, /**< Pointer to the element array. */
	count: i32,    /**< Number of elements in the vector. */
	size:  i32,    /**< Allocated capacity in number of elements. */
}

@(default_calling_convention="c")
foreign lib {
	/** Initialize a vector.
	*
	* @param allocator Allocator to use for memory management.
	* @param vec The vector to initialize.
	* @param size Size of each element in bytes.
	* @param elem_count Initial number of elements to allocate.
	*/
	ecs_vec_init :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) ---

	/** Initialize a vector with debug info.
	*
	* @param allocator Allocator to use for memory management.
	* @param vec The vector to initialize.
	* @param size Size of each element in bytes.
	* @param elem_count Initial number of elements to allocate.
	* @param type_name Type name string for debugging.
	*/
	ecs_vec_init_w_dbg_info :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32, type_name: cstring) ---

	/** Initialize a vector if it is not already initialized.
	*
	* @param vec The vector to initialize.
	* @param size Size of each element in bytes.
	*/
	ecs_vec_init_if :: proc(vec: ^ecs_vec_t, size: ecs_size_t) ---

	/** Deinitialize a vector.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to deinitialize.
	* @param size Size of each element in bytes.
	*/
	ecs_vec_fini :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t) ---

	/** Reset a vector. Keeps allocated memory for reuse.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to reset.
	* @param size Size of each element in bytes.
	* @return Pointer to the reset vector.
	*/
	ecs_vec_reset :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t) -> ^ecs_vec_t ---

	/** Clear a vector. Sets count to zero without freeing memory.
	*
	* @param vec The vector to clear.
	*/
	ecs_vec_clear :: proc(vec: ^ecs_vec_t) ---

	/** Append a new element to the vector.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to append to.
	* @param size Size of each element in bytes.
	* @return Pointer to the newly appended element.
	*/
	ecs_vec_append :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t) -> rawptr ---

	/** Remove an element by swapping with the last element.
	*
	* @param vec The vector to remove from.
	* @param size Size of each element in bytes.
	* @param elem Index of the element to remove.
	*/
	ecs_vec_remove :: proc(vec: ^ecs_vec_t, size: ecs_size_t, elem: i32) ---

	/** Remove an element while preserving order.
	*
	* @param v The vector to remove from.
	* @param size Size of each element in bytes.
	* @param index Index of the element to remove.
	*/
	ecs_vec_remove_ordered :: proc(v: ^ecs_vec_t, size: ecs_size_t, index: i32) ---

	/** Remove the last element from the vector.
	*
	* @param vec The vector to remove from.
	*/
	ecs_vec_remove_last :: proc(vec: ^ecs_vec_t) ---

	/** Copy a vector.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The source vector to copy.
	* @param size Size of each element in bytes.
	* @return A new vector containing copies of all elements.
	*/
	ecs_vec_copy :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t) -> ecs_vec_t ---

	/** Copy a vector and shrink to fit.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The source vector to copy.
	* @param size Size of each element in bytes.
	* @return A new vector with capacity shrunk to its count.
	*/
	ecs_vec_copy_shrink :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t) -> ecs_vec_t ---

	/** Reclaim unused memory. Shrinks the vector's allocation to fit its count.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to reclaim memory from.
	* @param size Size of each element in bytes.
	*/
	ecs_vec_reclaim :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t) ---

	/** Set the capacity of a vector.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to resize.
	* @param size Size of each element in bytes.
	* @param elem_count Desired capacity in number of elements.
	*/
	ecs_vec_set_size :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) ---

	/** Set the minimum capacity of a vector. Does not shrink.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to resize.
	* @param size Size of each element in bytes.
	* @param elem_count Minimum capacity in number of elements.
	*/
	ecs_vec_set_min_size :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) ---

	/** Set the minimum capacity using type info for lifecycle management.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to resize.
	* @param size Size of each element in bytes.
	* @param elem_count Minimum capacity in number of elements.
	* @param ti Type info for lifecycle callbacks.
	*/
	ecs_vec_set_min_size_w_type_info :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32, ti: ^ecs_type_info_t) ---

	/** Set the minimum count. Increases count if smaller than elem_count.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to modify.
	* @param size Size of each element in bytes.
	* @param elem_count Minimum element count.
	*/
	ecs_vec_set_min_count :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) ---

	/** Set the minimum count and zero-initialize new elements.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to modify.
	* @param size Size of each element in bytes.
	* @param elem_count Minimum element count.
	*/
	ecs_vec_set_min_count_zeromem :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) ---

	/** Set the element count of a vector.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to modify.
	* @param size Size of each element in bytes.
	* @param elem_count Desired element count.
	*/
	ecs_vec_set_count :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) ---

	/** Set the element count using type info for lifecycle management.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to modify.
	* @param size Size of each element in bytes.
	* @param elem_count Desired element count.
	* @param ti Type info for lifecycle callbacks.
	*/
	ecs_vec_set_count_w_type_info :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32, ti: ^ecs_type_info_t) ---

	/** Set the minimum count using type info for lifecycle management.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to modify.
	* @param size Size of each element in bytes.
	* @param elem_count Minimum element count.
	* @param ti Type info for lifecycle callbacks.
	*/
	ecs_vec_set_min_count_w_type_info :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32, ti: ^ecs_type_info_t) ---

	/** Grow the vector by a number of elements.
	*
	* @param allocator Allocator used for memory management.
	* @param vec The vector to grow.
	* @param size Size of each element in bytes.
	* @param elem_count Number of elements to grow by.
	* @return Pointer to the first newly added element.
	*/
	ecs_vec_grow :: proc(allocator: ^ecs_allocator_t, vec: ^ecs_vec_t, size: ecs_size_t, elem_count: i32) -> rawptr ---

	/** Return the number of elements in the vector.
	*
	* @param vec The vector.
	* @return The number of elements.
	*/
	ecs_vec_count :: proc(vec: ^ecs_vec_t) -> i32 ---

	/** Return the allocated capacity of the vector.
	*
	* @param vec The vector.
	* @return The allocated capacity in number of elements.
	*/
	ecs_vec_size :: proc(vec: ^ecs_vec_t) -> i32 ---

	/** Get a pointer to an element at the given index.
	*
	* @param vec The vector.
	* @param size Size of each element in bytes.
	* @param index Index of the element to retrieve.
	* @return Pointer to the element.
	*/
	ecs_vec_get :: proc(vec: ^ecs_vec_t, size: ecs_size_t, index: i32) -> rawptr ---

	/** Get a pointer to the first element.
	*
	* @param vec The vector.
	* @return Pointer to the first element, or NULL if empty.
	*/
	ecs_vec_first :: proc(vec: ^ecs_vec_t) -> rawptr ---

	/** Get a pointer to the last element.
	*
	* @param vec The vector.
	* @param size Size of each element in bytes.
	* @return Pointer to the last element, or NULL if empty.
	*/
	ecs_vec_last :: proc(vec: ^ecs_vec_t, size: ecs_size_t) -> rawptr ---
}

/** The number of elements in a single page. */
FLECS_SPARSE_PAGE_SIZE :: (1<<FLECS_SPARSE_PAGE_BITS)

/** A page in the sparse set containing a sparse-to-dense mapping and data. */
ecs_sparse_page_t :: struct {
	sparse: ^i32,   /**< Sparse array with indices to dense array. */
	data:   rawptr, /**< Store data in sparse array to reduce
                                 *   indirection and provide stable pointers. */
}

/** A sparse set data structure for O(1) access with stable pointers. */
ecs_sparse_t :: struct {
	dense:          ecs_vec_t,              /**< Dense array with indices to sparse array. The
                                 *   dense array stores both alive and not alive
                                 *   sparse indices. The 'count' member keeps
                                 *   track of which indices are alive. */
	pages:          ecs_vec_t,              /**< Chunks with sparse arrays and data. */
	size:           ecs_size_t,             /**< Element size in bytes. */
	count:          i32,                    /**< Number of alive entries. */
	max_id:         u64,                    /**< Local max index (if no global is set). */
	allocator:      ^ecs_allocator_t,       /**< Allocator for general allocations. */
	page_allocator: ^ecs_block_allocator_t, /**< Allocator for page allocations. */
}

@(default_calling_convention="c")
foreign lib {
	/** Initialize a sparse set.
	*
	* @param result The sparse set to initialize.
	* @param allocator Allocator for general memory management.
	* @param page_allocator Block allocator for page allocations.
	* @param size Size of each element in bytes.
	*/
	flecs_sparse_init :: proc(result: ^ecs_sparse_t, allocator: ^ecs_allocator_t, page_allocator: ^ecs_block_allocator_t, size: ecs_size_t) ---

	/** Deinitialize a sparse set.
	*
	* @param sparse The sparse set to deinitialize.
	*/
	flecs_sparse_fini :: proc(sparse: ^ecs_sparse_t) ---

	/** Remove all elements from a sparse set.
	*
	* @param sparse The sparse set to clear.
	*/
	flecs_sparse_clear :: proc(sparse: ^ecs_sparse_t) ---

	/** Add an element to a sparse set. This generates or recycles an ID.
	*
	* @param sparse The sparse set to add to.
	* @param elem_size Size of each element in bytes.
	* @return Pointer to the newly added element.
	*/
	flecs_sparse_add :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t) -> rawptr ---

	/** Get the last issued ID.
	*
	* @param sparse The sparse set.
	* @return The last issued ID.
	*/
	flecs_sparse_last_id :: proc(sparse: ^ecs_sparse_t) -> u64 ---

	/** Generate or recycle a new ID.
	*
	* @param sparse The sparse set.
	* @return A new or recycled ID.
	*/
	flecs_sparse_new_id :: proc(sparse: ^ecs_sparse_t) -> u64 ---

	/** Remove an element.
	*
	* @param sparse The sparse set to remove from.
	* @param size Size of each element in bytes.
	* @param id The ID of the element to remove.
	* @return True if the element was found and removed.
	*/
	flecs_sparse_remove :: proc(sparse: ^ecs_sparse_t, size: ecs_size_t, id: u64) -> bool ---

	/** Remove an element and increase the generation.
	*
	* @param sparse The sparse set to remove from.
	* @param size Size of each element in bytes.
	* @param id The ID of the element to remove.
	* @return True if the element was found and removed.
	*/
	flecs_sparse_remove_w_gen :: proc(sparse: ^ecs_sparse_t, size: ecs_size_t, id: u64) -> bool ---

	/** Test if an ID is alive, which requires the generation count to match.
	*
	* @param sparse The sparse set to check.
	* @param id The ID to test for liveness.
	* @return True if the ID is alive.
	*/
	flecs_sparse_is_alive :: proc(sparse: ^ecs_sparse_t, id: u64) -> bool ---

	/** Get a value from a sparse set by dense ID. This function is useful in
	* combination with flecs_sparse_count() for iterating all values in the set.
	*
	* @param sparse The sparse set to retrieve from.
	* @param elem_size Size of each element in bytes.
	* @param index Dense index of the element.
	* @return Pointer to the element at the given dense index.
	*/
	flecs_sparse_get_dense :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, index: i32) -> rawptr ---

	/** Get the number of alive elements in the sparse set.
	*
	* @param sparse The sparse set.
	* @return The number of alive elements.
	*/
	flecs_sparse_count :: proc(sparse: ^ecs_sparse_t) -> i32 ---

	/** Check if a sparse set has an ID.
	*
	* @param sparse The sparse set to check.
	* @param id The ID to look for.
	* @return True if the sparse set contains the ID.
	*/
	flecs_sparse_has :: proc(sparse: ^ecs_sparse_t, id: u64) -> bool ---

	/** Get element by sparse ID, regardless of whether the element is alive or not.
	*
	* @param sparse The sparse set to retrieve from.
	* @param elem_size Size of each element in bytes.
	* @param id The sparse ID of the element.
	* @return Pointer to the element, regardless of liveness.
	*/
	flecs_sparse_get :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, id: u64) -> rawptr ---

	/** Create an element by (sparse) ID.
	*
	* @param sparse The sparse set to insert into.
	* @param elem_size Size of each element in bytes.
	* @param id The sparse ID for the new element.
	* @return Pointer to the newly created element.
	*/
	flecs_sparse_insert :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, id: u64) -> rawptr ---

	/** Get or create an element by (sparse) ID.
	*
	* @param sparse The sparse set.
	* @param elem_size Size of each element in bytes.
	* @param id The sparse ID to get or create.
	* @param is_new Output parameter set to true if a new element was created.
	* @return Pointer to the existing or newly created element.
	*/
	flecs_sparse_ensure :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, id: u64, is_new: ^bool) -> rawptr ---

	/** Fast version of ensure with no liveness checking.
	*
	* @param sparse The sparse set.
	* @param elem_size Size of each element in bytes.
	* @param id The sparse ID to get or create.
	* @return Pointer to the element.
	*/
	flecs_sparse_ensure_fast :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, id: u64) -> rawptr ---

	/** Get a pointer to IDs (alive and not alive). Use with flecs_sparse_count().
	*
	* @param sparse The sparse set.
	* @return Pointer to the dense array of IDs.
	*/
	flecs_sparse_ids :: proc(sparse: ^ecs_sparse_t) -> ^u64 ---

	/** Shrink sparse set memory to fit current usage.
	*
	* @param sparse The sparse set to shrink.
	*/
	flecs_sparse_shrink :: proc(sparse: ^ecs_sparse_t) ---

	/** Initialize a public sparse set.
	*
	* @param sparse The sparse set to initialize.
	* @param elem_size Size of each element in bytes.
	*/
	ecs_sparse_init :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t) ---

	/** Add an element to a public sparse set.
	*
	* @param sparse The sparse set to add to.
	* @param elem_size Size of each element in bytes.
	* @return Pointer to the newly added element.
	*/
	ecs_sparse_add :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t) -> rawptr ---

	/** Get the last issued ID from a public sparse set.
	*
	* @param sparse The sparse set.
	* @return The last issued ID.
	*/
	ecs_sparse_last_id :: proc(sparse: ^ecs_sparse_t) -> u64 ---

	/** Get the number of alive elements in a public sparse set.
	*
	* @param sparse The sparse set.
	* @return The number of alive elements.
	*/
	ecs_sparse_count :: proc(sparse: ^ecs_sparse_t) -> i32 ---

	/** Get a value from a public sparse set by dense index.
	*
	* @param sparse The sparse set.
	* @param elem_size Size of each element in bytes.
	* @param index Dense index of the element.
	* @return Pointer to the element.
	*/
	ecs_sparse_get_dense :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, index: i32) -> rawptr ---

	/** Get a value from a public sparse set by sparse ID.
	*
	* @param sparse The sparse set.
	* @param elem_size Size of each element in bytes.
	* @param id The sparse ID of the element.
	* @return Pointer to the element.
	*/
	ecs_sparse_get :: proc(sparse: ^ecs_sparse_t, elem_size: ecs_size_t, id: u64) -> rawptr ---
}

/** A block of memory managed by the block allocator. */
ecs_block_allocator_block_t :: struct {
	memory: rawptr,                       /**< Pointer to the block memory. */
	next:   ^ecs_block_allocator_block_t, /**< Next block in the list. */
}

/** Header for a free chunk in the block allocator free list. */
ecs_block_allocator_chunk_header_t :: struct {
	next: ^ecs_block_allocator_chunk_header_t, /**< Next free chunk. */
}

/** Block allocator that returns fixed-size memory blocks. */
ecs_block_allocator_t :: struct {
	data_size:        i32,                                 /**< Size of each allocation. */
	chunk_size:       i32,                                 /**< Aligned chunk size including header. */
	chunks_per_block: i32,                                 /**< Number of chunks per block. */
	block_size:       i32,                                 /**< Total size of each allocated block. */
	head:             ^ecs_block_allocator_chunk_header_t, /**< Head of the free chunk list. */
	block_head:       ^ecs_block_allocator_block_t,        /**< Head of the allocated block list. */
}

@(default_calling_convention="c")
foreign lib {



	@(link_name="FLECS_IDecs_f32_tID_")
	ecs_f32_id: ecs_entity_t	
	/** Initialize a block allocator.
	*
	* @param ba The block allocator to initialize.
	* @param size The size of each allocation.
	*/
	flecs_ballocator_init :: proc(ba: ^ecs_block_allocator_t, size: ecs_size_t) ---

	/** Create a new block allocator on the heap.
	*
	* @param size The size of each allocation.
	* @return The new block allocator.
	*/
	flecs_ballocator_new :: proc(size: ecs_size_t) -> ^ecs_block_allocator_t ---

	/** Deinitialize a block allocator.
	*
	* @param ba The block allocator to deinitialize.
	*/
	flecs_ballocator_fini :: proc(ba: ^ecs_block_allocator_t) ---

	/** Free a block allocator created with flecs_ballocator_new().
	*
	* @param ba The block allocator to free.
	*/
	flecs_ballocator_free :: proc(ba: ^ecs_block_allocator_t) ---

	/** Allocate a block of memory.
	*
	* @param allocator The block allocator.
	* @return Pointer to the allocated memory.
	*/
	flecs_balloc :: proc(allocator: ^ecs_block_allocator_t) -> rawptr ---

	/** Allocate a block of memory with debug type name info.
	*
	* @param allocator The block allocator.
	* @param type_name The type name for debug tracking.
	* @return Pointer to the allocated memory.
	*/
	flecs_balloc_w_dbg_info :: proc(allocator: ^ecs_block_allocator_t, type_name: cstring) -> rawptr ---

	/** Allocate a zeroed block of memory.
	*
	* @param allocator The block allocator.
	* @return Pointer to the zeroed memory.
	*/
	flecs_bcalloc :: proc(allocator: ^ecs_block_allocator_t) -> rawptr ---

	/** Allocate a zeroed block of memory with debug type name info.
	*
	* @param allocator The block allocator.
	* @param type_name The type name for debug tracking.
	* @return Pointer to the zeroed memory.
	*/
	flecs_bcalloc_w_dbg_info :: proc(allocator: ^ecs_block_allocator_t, type_name: cstring) -> rawptr ---

	/** Free a block of memory.
	*
	* @param allocator The block allocator.
	* @param memory The memory to free.
	*/
	flecs_bfree :: proc(allocator: ^ecs_block_allocator_t, memory: rawptr) ---

	/** Free a block of memory with debug type name info.
	*
	* @param allocator The block allocator.
	* @param memory The memory to free.
	* @param type_name The type name for debug tracking.
	*/
	flecs_bfree_w_dbg_info :: proc(allocator: ^ecs_block_allocator_t, memory: rawptr, type_name: cstring) ---

	/** Reallocate a block from one block allocator to another.
	*
	* @param dst The destination block allocator.
	* @param src The source block allocator.
	* @param memory The memory to reallocate.
	* @return Pointer to the reallocated memory.
	*/
	flecs_brealloc :: proc(dst: ^ecs_block_allocator_t, src: ^ecs_block_allocator_t, memory: rawptr) -> rawptr ---

	/** Reallocate a block with debug type name info.
	*
	* @param dst The destination block allocator.
	* @param src The source block allocator.
	* @param memory The memory to reallocate.
	* @param type_name The type name for debug tracking.
	* @return Pointer to the reallocated memory.
	*/
	flecs_brealloc_w_dbg_info :: proc(dst: ^ecs_block_allocator_t, src: ^ecs_block_allocator_t, memory: rawptr, type_name: cstring) -> rawptr ---

	/** Duplicate a block of memory.
	*
	* @param ba The block allocator.
	* @param memory The memory to duplicate.
	* @return Pointer to the duplicated memory.
	*/
	flecs_bdup :: proc(ba: ^ecs_block_allocator_t, memory: rawptr) -> rawptr ---
}

/** A page of memory in the stack allocator. */
ecs_stack_page_t :: struct {
	data: rawptr,            /**< Pointer to the page data. */
	next: ^ecs_stack_page_t, /**< Next page in the list. */
	sp:   i16,               /**< Current stack pointer within the page. */
	id:   u32,               /**< Page identifier. */
}

/** Cursor that marks a position in the stack allocator for later restoration. */
ecs_stack_cursor_t :: struct {
	prev:    ^ecs_stack_cursor_t, /**< Previous cursor in the stack. */
	page:    ^ecs_stack_page_t,   /**< Page at the cursor position. */
	sp:      i16,                 /**< Stack pointer at the cursor position. */
	is_free: bool,                /**< Whether this cursor has been freed. */
	owner:   ^ecs_stack_t,        /**< Stack allocator that owns this cursor (debug only). */
}

/** Stack allocator for quick allocation of small temporary values. */
ecs_stack_t :: struct {
	first:        ^ecs_stack_page_t,   /**< First page in the stack. */
	tail_page:    ^ecs_stack_page_t,   /**< Current tail page. */
	tail_cursor:  ^ecs_stack_cursor_t, /**< Current tail cursor. */
	cursor_count: i32,                 /**< Number of active cursors (debug only). */
}

/** Offset of usable data within a stack page (aligned to 16 bytes). */
FLECS_STACK_PAGE_OFFSET :: ecs_size_t(
    ((size_of(ecs_stack_page_t) - 1) / 16 + 1) * 16
)

/** Size of usable data within a stack page. */
FLECS_STACK_PAGE_SIZE :: 1024 - FLECS_STACK_PAGE_OFFSET

@(default_calling_convention="c")
foreign lib {
	/** Initialize a stack allocator.
	*
	* @param stack The stack allocator to initialize.
	*/
	flecs_stack_init :: proc(stack: ^ecs_stack_t) ---

	/** Deinitialize a stack allocator.
	*
	* @param stack The stack allocator to deinitialize.
	*/
	flecs_stack_fini :: proc(stack: ^ecs_stack_t) ---

	/** Allocate memory from the stack.
	*
	* @param stack The stack allocator.
	* @param size The allocation size.
	* @param align The required alignment.
	* @return Pointer to the allocated memory.
	*/
	flecs_stack_alloc :: proc(stack: ^ecs_stack_t, size: ecs_size_t, align: ecs_size_t) -> rawptr ---

	/** Allocate zeroed memory from the stack.
	*
	* @param stack The stack allocator.
	* @param size The allocation size.
	* @param align The required alignment.
	* @return Pointer to the zeroed memory.
	*/
	flecs_stack_calloc :: proc(stack: ^ecs_stack_t, size: ecs_size_t, align: ecs_size_t) -> rawptr ---

	/** Free memory allocated from the stack.
	*
	* @param ptr The pointer to free.
	* @param size The size of the allocation.
	*/
	flecs_stack_free :: proc(ptr: rawptr, size: ecs_size_t) ---

	/** Reset the stack allocator.
	*
	* @param stack The stack allocator to reset.
	*/
	flecs_stack_reset :: proc(stack: ^ecs_stack_t) ---

	/** Get a cursor marking the current position in the stack.
	*
	* @param stack The stack allocator.
	* @return A cursor that can be used to restore the stack.
	*/
	flecs_stack_get_cursor :: proc(stack: ^ecs_stack_t) -> ^ecs_stack_cursor_t ---

	/** Restore the stack to a previously saved cursor position.
	*
	* @param stack The stack allocator.
	* @param cursor The cursor to restore to.
	*/
	flecs_stack_restore_cursor :: proc(stack: ^ecs_stack_t, cursor: ^ecs_stack_cursor_t) ---
}

/** Data type for map key-value storage. */
ecs_map_data_t :: u64

/** Map key type. */
ecs_map_key_t :: ecs_map_data_t

/** Map value type. */
ecs_map_val_t :: ecs_map_data_t

/** A single entry in a map bucket (linked list node). */
ecs_bucket_entry_t :: struct {
	key:   ecs_map_key_t,       /**< Key of the entry. */
	value: ecs_map_val_t,       /**< Value of the entry. */
	next:  ^ecs_bucket_entry_t, /**< Next entry in the bucket chain. */
}

/** A bucket in the map hash table. */
ecs_bucket_t :: struct {
	first: ^ecs_bucket_entry_t, /**< First entry in this bucket. */
}

/** A hashmap data structure. */
ecs_map_t :: struct {
	buckets:       ^ecs_bucket_t,    /**< Array of hash buckets. */
	bucket_count:  i32,              /**< Total number of buckets. */
	count:         u32,              /**< Number of elements in the map. */
	bucket_shift:  u32,              /**< Bit shift for bucket index computation. */
	allocator:     ^ecs_allocator_t, /**< Allocator used for memory management. */
	change_count:  i32,              /**< Track modifications while iterating. */
	last_iterated: ecs_map_key_t,    /**< Currently iterated element. */
}

/** Iterator for traversing map contents. */
ecs_map_iter_t :: struct {
	_map:         ^ecs_map_t,          /**< The map being iterated. */
	bucket:       ^ecs_bucket_t,       /**< Current bucket. */
	entry:        ^ecs_bucket_entry_t, /**< Current entry in the bucket. */
	res:          ^ecs_map_data_t,     /**< Pointer to current key-value pair. */
	change_count: i32,                 /**< Change count at iterator creation for modification detection. */
}

@(default_calling_convention="c")
foreign lib {
	/** Initialize a new map.
	*
	* @param map The map to initialize.
	* @param allocator Allocator to use for memory management.
	*/
	ecs_map_init :: proc(_map: ^ecs_map_t, allocator: ^ecs_allocator_t) ---

	/** Initialize a new map if uninitialized, leave as is otherwise.
	*
	* @param map The map to initialize.
	* @param allocator Allocator to use for memory management.
	*/
	ecs_map_init_if :: proc(_map: ^ecs_map_t, allocator: ^ecs_allocator_t) ---

	/** Reclaim map memory.
	*
	* @param map The map to reclaim memory from.
	*/
	ecs_map_reclaim :: proc(_map: ^ecs_map_t) ---

	/** Deinitialize a map.
	*
	* @param map The map to deinitialize.
	*/
	ecs_map_fini :: proc(_map: ^ecs_map_t) ---

	/** Get an element for a key. Returns NULL if the key doesn't exist.
	*
	* @param map The map to search.
	* @param key The key to look up.
	* @return Pointer to the value, or NULL if the key was not found.
	*/
	ecs_map_get :: proc(_map: ^ecs_map_t, key: ecs_map_key_t) -> ^ecs_map_val_t ---

	/** Get element as pointer (auto-dereferences _ptr).
	*
	* @param map The map to search.
	* @param key The key to look up.
	* @return Dereferenced pointer value, or NULL if the key was not found.
	*/
	ecs_map_get_deref_ :: proc(_map: ^ecs_map_t, key: ecs_map_key_t) -> rawptr ---

	/** Get or insert an element for a key.
	*
	* @param map The map to get or insert into.
	* @param key The key to look up or insert.
	* @return Pointer to the existing or newly inserted value.
	*/
	ecs_map_ensure :: proc(_map: ^ecs_map_t, key: ecs_map_key_t) -> ^ecs_map_val_t ---

	/** Get or insert a pointer element for a key. Allocate if the pointer is NULL.
	*
	* @param map The map to get or insert into.
	* @param elem_size Size of the element to allocate.
	* @param key The key to look up or insert.
	* @return Pointer to the existing or newly allocated element.
	*/
	ecs_map_ensure_alloc :: proc(_map: ^ecs_map_t, elem_size: ecs_size_t, key: ecs_map_key_t) -> rawptr ---

	/** Insert an element for a key.
	*
	* @param map The map to insert into.
	* @param key The key for the new element.
	* @param value The value to insert.
	*/
	ecs_map_insert :: proc(_map: ^ecs_map_t, key: ecs_map_key_t, value: ecs_map_val_t) ---

	/** Insert a pointer element for a key, populate with a new allocation.
	*
	* @param map The map to insert into.
	* @param elem_size Size of the element to allocate.
	* @param key The key for the new element.
	* @return Pointer to the newly allocated element.
	*/
	ecs_map_insert_alloc :: proc(_map: ^ecs_map_t, elem_size: ecs_size_t, key: ecs_map_key_t) -> rawptr ---

	/** Remove a key from the map.
	*
	* @param map The map to remove from.
	* @param key The key to remove.
	* @return The removed value.
	*/
	ecs_map_remove :: proc(_map: ^ecs_map_t, key: ecs_map_key_t) -> ecs_map_val_t ---

	/** Remove a pointer element. Free if not NULL.
	*
	* @param map The map to remove from.
	* @param key The key to remove and free.
	*/
	ecs_map_remove_free :: proc(_map: ^ecs_map_t, key: ecs_map_key_t) ---

	/** Remove all elements from the map.
	*
	* @param map The map to clear.
	*/
	ecs_map_clear :: proc(_map: ^ecs_map_t) ---

	/** Return an iterator to map contents.
	*
	* @param map The map to iterate.
	* @return A new iterator positioned before the first element.
	*/
	ecs_map_iter :: proc(_map: ^ecs_map_t) -> ecs_map_iter_t ---

	/** Return whether the map iterator is valid.
	*
	* @param iter The iterator to check.
	* @return True if the iterator is valid.
	*/
	ecs_map_iter_valid :: proc(iter: ^ecs_map_iter_t) -> bool ---

	/** Obtain the next element in the map from the iterator.
	*
	* @param iter The iterator to advance.
	* @return True if a next element was found, false if iteration is done.
	*/
	ecs_map_next :: proc(iter: ^ecs_map_iter_t) -> bool ---

	/** Copy a map.
	*
	* @param dst The destination map.
	* @param src The source map to copy from.
	*/
	ecs_map_copy :: proc(dst: ^ecs_map_t, src: ^ecs_map_t) ---
}

/** General purpose allocator that manages block allocators for different sizes. */
ecs_allocator_t :: struct {
	chunks: ecs_block_allocator_t, /**< Block allocator for chunk storage. */
	sizes:  ecs_sparse_t,          /**< Sparse set mapping size to block allocator. */
}

@(default_calling_convention="c")
foreign lib {
	/** Initialize an allocator.
	*
	* @param a The allocator to initialize.
	*/
	flecs_allocator_init :: proc(a: ^ecs_allocator_t) ---

	/** Deinitialize an allocator.
	*
	* @param a The allocator to deinitialize.
	*/
	flecs_allocator_fini :: proc(a: ^ecs_allocator_t) ---

	/** Get or create a block allocator for the specified size.
	*
	* @param a The allocator.
	* @param size The allocation size.
	* @return The block allocator for the given size.
	*/
	flecs_allocator_get :: proc(a: ^ecs_allocator_t, size: ecs_size_t) -> ^ecs_block_allocator_t ---

	/** Duplicate a string using the allocator.
	*
	* @param a The allocator.
	* @param str The string to duplicate.
	* @return The duplicated string.
	*/
	flecs_strdup :: proc(a: ^ecs_allocator_t, str: cstring) -> cstring ---

	/** Free a string previously allocated with flecs_strdup().
	*
	* @param a The allocator.
	* @param str The string to free.
	*/
	flecs_strfree :: proc(a: ^ecs_allocator_t, str: cstring) ---

	/** Duplicate a memory block using the allocator.
	*
	* @param a The allocator.
	* @param size The size of the memory block.
	* @param src The source memory to duplicate.
	* @return Pointer to the duplicated memory.
	*/
	flecs_dup :: proc(a: ^ecs_allocator_t, size: ecs_size_t, src: rawptr) -> rawptr ---
}

ECS_STRBUF_INIT :: ecs_strbuf_t{}

/** Size of the small string optimization buffer. */
ECS_STRBUF_SMALL_STRING_SIZE :: (512)

/** Maximum nesting depth for list operations. */
ECS_STRBUF_MAX_LIST_DEPTH :: (32)

/** Element tracking for nested list appends. */
ecs_strbuf_list_elem :: struct {
	count:     i32,     /**< Number of elements appended to the list. */
	separator: cstring, /**< Separator string inserted between elements. */
}

/** A string buffer for efficient string construction. */
ecs_strbuf_t :: struct {
	content:      cstring,                  /**< Pointer to the heap-allocated string content. */
	length:       ecs_size_t,               /**< Current length of the string in bytes. */
	size:         ecs_size_t,               /**< Allocated capacity of the content buffer. */
	list_stack:   [32]ecs_strbuf_list_elem, /**< Stack of nested list states. */
	list_sp:      i32,                      /**< Current list stack pointer (nesting depth). */
	small_string: [512]i8,                  /**< Inline buffer for small string optimization. */
}

@(default_calling_convention="c")
foreign lib {
	/** Append a format string to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param fmt The format string.
	*/
	ecs_strbuf_append :: proc(buffer: ^ecs_strbuf_t, fmt: cstring, #c_vararg _: ..any) ---

	/** Append a format string with an argument list to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param fmt The format string.
	* @param args The format argument list.
	*/
	ecs_strbuf_vappend :: proc(buffer: ^ecs_strbuf_t, fmt: cstring, args: c.va_list) ---

	/** Append a string to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param str The string to append.
	*/
	ecs_strbuf_appendstr :: proc(buffer: ^ecs_strbuf_t, str: cstring) ---

	/** Append a character to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param ch The character to append.
	*/
	ecs_strbuf_appendch :: proc(buffer: ^ecs_strbuf_t, ch: i8) ---

	/** Append an int to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param v The integer value to append.
	*/
	ecs_strbuf_appendint :: proc(buffer: ^ecs_strbuf_t, v: i64) ---

	/** Append a float to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param v The float value to append.
	* @param nan_delim The delimiter to use for NaN values.
	*/
	ecs_strbuf_appendflt :: proc(buffer: ^ecs_strbuf_t, v: f64, nan_delim: i8) ---

	/** Append a boolean to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param v The boolean value to append.
	*/
	ecs_strbuf_appendbool :: proc(buffer: ^ecs_strbuf_t, v: bool) ---

	/** Append a source buffer to a destination buffer.
	*
	* @param dst_buffer The destination buffer.
	* @param src_buffer The source buffer to append.
	*/
	ecs_strbuf_mergebuff :: proc(dst_buffer: ^ecs_strbuf_t, src_buffer: ^ecs_strbuf_t) ---

	/** Append n characters to a buffer.
	*
	* @param buffer The buffer to append to.
	* @param str The string to append from.
	* @param n The number of characters to append.
	*/
	ecs_strbuf_appendstrn :: proc(buffer: ^ecs_strbuf_t, str: cstring, n: i32) ---

	/** Return the result string.
	*
	* @param buffer The buffer to get the string from.
	* @return The result string, or NULL if empty.
	*/
	ecs_strbuf_get :: proc(buffer: ^ecs_strbuf_t) -> cstring ---

	/** Return the small string from the first element (appends \\0).
	*
	* @param buffer The buffer to get the string from.
	* @return The small string.
	*/
	ecs_strbuf_get_small :: proc(buffer: ^ecs_strbuf_t) -> cstring ---

	/** Reset a buffer without returning a string.
	*
	* @param buffer The buffer to reset.
	*/
	ecs_strbuf_reset :: proc(buffer: ^ecs_strbuf_t) ---

	/** Push a list.
	*
	* @param buffer The buffer.
	* @param list_open The string used to open the list.
	* @param separator The separator string inserted between elements.
	*/
	ecs_strbuf_list_push :: proc(buffer: ^ecs_strbuf_t, list_open: cstring, separator: cstring) ---

	/** Pop a list.
	*
	* @param buffer The buffer.
	* @param list_close The string used to close the list.
	*/
	ecs_strbuf_list_pop :: proc(buffer: ^ecs_strbuf_t, list_close: cstring) ---

	/** Insert a new element in the list.
	*
	* @param buffer The buffer.
	*/
	ecs_strbuf_list_next :: proc(buffer: ^ecs_strbuf_t) ---

	/** Append a character as a new element in the list.
	*
	* @param buffer The buffer.
	* @param ch The character to append.
	*/
	ecs_strbuf_list_appendch :: proc(buffer: ^ecs_strbuf_t, ch: i8) ---

	/** Append a formatted string as a new element in the list.
	*
	* @param buffer The buffer.
	* @param fmt The format string.
	*/
	ecs_strbuf_list_append :: proc(buffer: ^ecs_strbuf_t, fmt: cstring, #c_vararg _: ..any) ---

	/** Append a string as a new element in the list.
	*
	* @param buffer The buffer.
	* @param str The string to append.
	*/
	ecs_strbuf_list_appendstr :: proc(buffer: ^ecs_strbuf_t, str: cstring) ---

	/** Append n characters as a new element in the list.
	*
	* @param buffer The buffer.
	* @param str The string to append from.
	* @param n The number of characters to append.
	*/
	ecs_strbuf_list_appendstrn :: proc(buffer: ^ecs_strbuf_t, str: cstring, n: i32) ---

	/** Return the number of bytes written to the buffer. */
	ecs_strbuf_written :: proc(buffer: ^ecs_strbuf_t) -> i32 ---
}

/** Time type. */
ecs_time_t :: struct {
	sec:     u32, /**< Second part. */
	nanosec: u32, /**< Nanosecond part. */
}

/** Use handle types that _at least_ can store pointers. */
ecs_os_thread_t :: c.uintptr_t /**< OS thread. */
ecs_os_cond_t   :: c.uintptr_t /**< OS cond. */
ecs_os_mutex_t  :: c.uintptr_t /**< OS mutex. */
ecs_os_dl_t     :: c.uintptr_t /**< OS dynamic library. */
ecs_os_sock_t   :: c.uintptr_t /**< OS socket. */

/** 64-bit thread ID. */
ecs_os_thread_id_t :: u64

/** Generic function pointer type. */
ecs_os_proc_t :: proc "c" ()

/** OS API init. */
ecs_os_api_init_t :: proc "c" ()

/** OS API deinit. */
ecs_os_api_fini_t :: proc "c" ()

/** OS API malloc function type. */
ecs_os_api_malloc_t :: proc "c" (size: ecs_size_t) -> rawptr

/** OS API free function type. */
ecs_os_api_free_t :: proc "c" (ptr: rawptr)

/** OS API realloc function type. */
ecs_os_api_realloc_t :: proc "c" (ptr: rawptr, size: ecs_size_t) -> rawptr

/** OS API calloc function type. */
ecs_os_api_calloc_t :: proc "c" (size: ecs_size_t) -> rawptr

/** OS API strdup function type. */
ecs_os_api_strdup_t :: proc "c" (str: cstring) -> cstring

/** OS API thread_callback function type. */
ecs_os_thread_callback_t :: proc "c" (rawptr) -> rawptr

/** OS API thread_new function type. */
ecs_os_api_thread_new_t :: proc "c" (callback: ecs_os_thread_callback_t, param: rawptr) -> ecs_os_thread_t

/** OS API thread_join function type. */
ecs_os_api_thread_join_t :: proc "c" (thread: ecs_os_thread_t) -> rawptr

/** OS API thread_self function type. */
ecs_os_api_thread_self_t :: proc "c" () -> ecs_os_thread_id_t

/** OS API task_new function type. */
ecs_os_api_task_new_t :: proc "c" (callback: ecs_os_thread_callback_t, param: rawptr) -> ecs_os_thread_t

/** OS API task_join function type. */
ecs_os_api_task_join_t :: proc "c" (thread: ecs_os_thread_t) -> rawptr

/** Atomic increment and decrement. */
/** OS API ainc function type. */
ecs_os_api_ainc_t :: proc "c" (value: ^i32) -> i32

/** OS API lainc function type. */
ecs_os_api_lainc_t :: proc "c" (value: ^i64) -> i64

/** Mutex. */
/** OS API mutex_new function type. */
ecs_os_api_mutex_new_t :: proc "c" () -> ecs_os_mutex_t

/** OS API mutex_lock function type. */
ecs_os_api_mutex_lock_t :: proc "c" (mutex: ecs_os_mutex_t)

/** OS API mutex_unlock function type. */
ecs_os_api_mutex_unlock_t :: proc "c" (mutex: ecs_os_mutex_t)

/** OS API mutex_free function type. */
ecs_os_api_mutex_free_t :: proc "c" (mutex: ecs_os_mutex_t)

/** Condition variable. */
/** OS API cond_new function type. */
ecs_os_api_cond_new_t :: proc "c" () -> ecs_os_cond_t

/** OS API cond_free function type. */
ecs_os_api_cond_free_t :: proc "c" (cond: ecs_os_cond_t)

/** OS API cond_signal function type. */
ecs_os_api_cond_signal_t :: proc "c" (cond: ecs_os_cond_t)

/** OS API cond_broadcast function type. */
ecs_os_api_cond_broadcast_t :: proc "c" (cond: ecs_os_cond_t)

/** OS API cond_wait function type. */
ecs_os_api_cond_wait_t :: proc "c" (cond: ecs_os_cond_t, mutex: ecs_os_mutex_t)

/** OS API sleep function type. */
ecs_os_api_sleep_t :: proc "c" (sec: i32, nanosec: i32)

/** OS API enable_high_timer_resolution function type. */
ecs_os_api_enable_high_timer_resolution_t :: proc "c" (enable: bool)

/** OS API get_time function type. */
ecs_os_api_get_time_t :: proc "c" (time_out: ^ecs_time_t)

/** OS API now function type. */
ecs_os_api_now_t :: proc "c" () -> u64

/** OS API log function type.
*
* @param level The logging level.
* @param file The file where the message was logged.
* @param line The line where it was logged.
* @param msg The log message.
*/
ecs_os_api_log_t :: proc "c" (level: i32, file: cstring, line: i32, msg: cstring)

/** OS API abort function type. */
ecs_os_api_abort_t :: proc "c" ()

/** OS API dlopen function type. */
ecs_os_api_dlopen_t :: proc "c" (libname: cstring) -> ecs_os_dl_t

/** OS API dlproc function type. */
ecs_os_api_dlproc_t :: proc "c" (lib: ecs_os_dl_t, procname: cstring) -> ecs_os_proc_t

/** OS API dlclose function type. */
ecs_os_api_dlclose_t :: proc "c" (lib: ecs_os_dl_t)

/** OS API module_to_path function type. */
ecs_os_api_module_to_path_t :: proc "c" (module_id: cstring) -> cstring

/** OS API fopen function type. */
ecs_os_api_fopen_t :: proc "c" (file: cstring, mode: cstring) -> ^libc.FILE

/** OS API fclose function type. */
ecs_os_api_fclose_t :: proc "c" (file: ^libc.FILE)

/** OS API performance tracing function type.
*
* @param filename The source file name.
* @param line The source line number.
* @param name The name of the trace region.
*/
ecs_os_api_perf_trace_t :: proc "c" (filename: cstring, line: c.size_t, name: cstring)

/** OS API interface. */
ecs_os_api_t :: struct {
	/* API init and deinit */
	init_: ecs_os_api_init_t, /**< init callback. */
	fini_: ecs_os_api_fini_t, /**< fini callback. */

	/* Memory management */
	malloc_:  ecs_os_api_malloc_t,  /**< malloc callback. */
	realloc_: ecs_os_api_realloc_t, /**< realloc callback. */
	calloc_:  ecs_os_api_calloc_t,  /**< calloc callback. */
	free_:    ecs_os_api_free_t,    /**< free callback. */

	/* Strings */
	strdup_: ecs_os_api_strdup_t, /**< strdup callback. */

	/* Threads */
	thread_new_:  ecs_os_api_thread_new_t,  /**< thread_new callback. */
	thread_join_: ecs_os_api_thread_join_t, /**< thread_join callback. */
	thread_self_: ecs_os_api_thread_self_t, /**< thread_self callback. */

	/* Tasks */
	task_new_:  ecs_os_api_thread_new_t,  /**< task_new callback. */
	task_join_: ecs_os_api_thread_join_t, /**< task_join callback. */

	/* Atomic increment and decrement */
	ainc_:  ecs_os_api_ainc_t,  /**< ainc callback. */
	adec_:  ecs_os_api_ainc_t,  /**< adec callback. */
	lainc_: ecs_os_api_lainc_t, /**< lainc callback. */
	ladec_: ecs_os_api_lainc_t, /**< ladec callback. */

	/* Mutex */
	mutex_new_:    ecs_os_api_mutex_new_t,  /**< mutex_new callback. */
	mutex_free_:   ecs_os_api_mutex_free_t, /**< mutex_free callback. */
	mutex_lock_:   ecs_os_api_mutex_lock_t, /**< mutex_lock callback. */
	mutex_unlock_: ecs_os_api_mutex_lock_t, /**< mutex_unlock callback. */

	/* Condition variable */
	cond_new_:       ecs_os_api_cond_new_t,       /**< cond_new callback. */
	cond_free_:      ecs_os_api_cond_free_t,      /**< cond_free callback. */
	cond_signal_:    ecs_os_api_cond_signal_t,    /**< cond_signal callback. */
	cond_broadcast_: ecs_os_api_cond_broadcast_t, /**< cond_broadcast callback. */
	cond_wait_:      ecs_os_api_cond_wait_t,      /**< cond_wait callback. */

	/* Time */
	sleep_:    ecs_os_api_sleep_t,    /**< sleep callback. */
	now_:      ecs_os_api_now_t,      /**< now callback. */
	get_time_: ecs_os_api_get_time_t, /**< get_time callback. */

	/* Logging */
	log_: ecs_os_api_log_t, /**< log callback.
                            * The level should be interpreted as:
                            * >0: Debug tracing. Only enabled in debug builds.
                            *  0: Tracing. Enabled in debug and release builds.
                            * -2: Warning. An issue occurred, but the operation was successful.
                            * -3: Error. An issue occurred, and the operation was unsuccessful.
                            * -4: Fatal. An issue occurred, and the application must quit. */

	/* Application termination */
	abort_: ecs_os_api_abort_t, /**< abort callback. */

	/* Dynamic library loading */
	dlopen_:  ecs_os_api_dlopen_t,  /**< dlopen callback. */
	dlproc_:  ecs_os_api_dlproc_t,  /**< dlproc callback. */
	dlclose_: ecs_os_api_dlclose_t, /**< dlclose callback. */

	/* Overridable function that translates from a logical module ID to a
	* shared library filename. */
	module_to_dl_: ecs_os_api_module_to_path_t, /**< module_to_dl callback. */

	/* Overridable function that translates from a logical module ID to a
	* path that contains module-specific resources or assets. */
	module_to_etc_: ecs_os_api_module_to_path_t, /**< module_to_etc callback. */

	/* File I/O */
	fopen_:  ecs_os_api_fopen_t,  /**< fopen callback. */
	fclose_: ecs_os_api_fclose_t, /**< fclose callback. */

	/* Performance tracing */
	perf_trace_push_:    ecs_os_api_perf_trace_t, /**< perf_trace_push callback. */
	perf_trace_pop_:     ecs_os_api_perf_trace_t, /**< perf_trace_pop callback. */
	log_level_:          i32,                     /**< Tracing level. */
	log_indent_:         i32,                     /**< Tracing indentation level. */
	log_last_error_:     i32,                     /**< Last logged error code. */
	log_last_timestamp_: i64,                     /**< Last logged timestamp. */
	flags_:              ecs_flags32_t,           /**< OS API flags. */
	log_out_:            rawptr,                  /**< File used for logging output (type is FILE*)
                                                    * (hint: log_ decides where to write). */
}

@(default_calling_convention="c")
foreign lib {
	/** Initialize the OS API.
	* This operation is not usually called by an application. To override callbacks
	* of the OS API, use the following pattern:
	*
	* @code
	* ecs_os_set_api_defaults();
	* ecs_os_api_t os_api = ecs_os_get_api();
	* os_api.abort_ = my_abort;
	* ecs_os_set_api(&os_api);
	* @endcode
	*/
	ecs_os_init :: proc() ---

	/** Deinitialize the OS API.
	* This operation is not usually called by an application.
	*/
	ecs_os_fini :: proc() ---

	/** Override the OS API.
	* This overrides the OS API struct with new values for callbacks. See
	* ecs_os_init() for how to use the function.
	*
	* @param os_api Pointer to a struct with values to set.
	*/
	ecs_os_set_api :: proc(os_api: ^ecs_os_api_t) ---

	/** Get the OS API.
	*
	* @return A value with the current OS API callbacks.
	* @see ecs_os_init()
	*/
	ecs_os_get_api :: proc() -> ecs_os_api_t ---

	/** Set default values for the OS API.
	* This initializes the OS API struct with default values for callbacks like
	* malloc and free.
	*
	* @see ecs_os_init()
	*/
	ecs_os_set_api_defaults :: proc() ---

	/** Log at debug level.
	*
	* @param file The source file.
	* @param line The source line.
	* @param msg The message to log.
	*/
	ecs_os_dbg :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at trace level.
	*
	* @param file The source file.
	* @param line The source line.
	* @param msg The message to log.
	*/
	ecs_os_trace :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at warning level.
	*
	* @param file The source file.
	* @param line The source line.
	* @param msg The message to log.
	*/
	ecs_os_warn :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at error level.
	*
	* @param file The source file.
	* @param line The source line.
	* @param msg The message to log.
	*/
	ecs_os_err :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Log at fatal level.
	*
	* @param file The source file.
	* @param line The source line.
	* @param msg The message to log.
	*/
	ecs_os_fatal :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Convert errno to a string.
	*
	* @param err The error number.
	* @return A string describing the error.
	*/
	ecs_os_strerror :: proc(err: i32) -> cstring ---

	/** A utility for assigning strings.
	* This operation frees an existing string and duplicates the input string.
	*
	* @param str Pointer to a string value.
	* @param value The string value to assign.
	*/
	ecs_os_strset :: proc(str: ^cstring, value: cstring) ---

	/** Push a performance trace region.
	*
	* @param file The source file name.
	* @param line The source line number.
	* @param name The name of the trace region.
	*/
	ecs_os_perf_trace_push_ :: proc(file: cstring, line: c.size_t, name: cstring) ---

	/** Pop a performance trace region.
	*
	* @param file The source file name.
	* @param line The source line number.
	* @param name The name of the trace region.
	*/
	ecs_os_perf_trace_pop_ :: proc(file: cstring, line: c.size_t, name: cstring) ---

	/** Sleep with floating-point time.
	*
	* @param t The time in seconds.
	*/
	ecs_sleepf :: proc(t: f64) ---

	/** Measure time since the provided timestamp.
	* Use with a time value initialized to 0 to obtain the number of seconds since
	* the epoch. The operation will write the current timestamp into start.
	*
	* Usage:
	* @code
	* ecs_time_t t = {};
	* ecs_time_measure(&t);
	* // code
	* double elapsed = ecs_time_measure(&t);
	* @endcode
	*
	* @param start The starting timestamp.
	* @return The time elapsed since start.
	*/
	ecs_time_measure :: proc(start: ^ecs_time_t) -> f64 ---

	/** Calculate the difference between two timestamps.
	*
	* @param t1 The first timestamp.
	* @param t2 The second timestamp.
	* @return The difference between timestamps.
	*/
	ecs_time_sub :: proc(t1: ecs_time_t, t2: ecs_time_t) -> ecs_time_t ---

	/** Convert a time value to a double.
	*
	* @param t The timestamp.
	* @return The timestamp converted to a double.
	*/
	ecs_time_to_double :: proc(t: ecs_time_t) -> f64 ---

	/** Return newly allocated memory that contains a copy of src.
	*
	* @param src The source pointer.
	* @param size The number of bytes to copy.
	* @return The duplicated memory.
	*/
	ecs_os_memdup :: proc(src: rawptr, size: ecs_size_t) -> rawptr ---

	/** Are heap functions available? */
	ecs_os_has_heap :: proc() -> bool ---

	/** Are threading functions available? */
	ecs_os_has_threading :: proc() -> bool ---

	/** Are task functions available? */
	ecs_os_has_task_support :: proc() -> bool ---

	/** Are time functions available? */
	ecs_os_has_time :: proc() -> bool ---

	/** Are logging functions available? */
	ecs_os_has_logging :: proc() -> bool ---

	/** Are dynamic library functions available? */
	ecs_os_has_dl :: proc() -> bool ---

	/** Are module path functions available? */
	ecs_os_has_modules :: proc() -> bool ---
}

/** Function prototype for runnables (systems, observers).
* The run callback overrides the default behavior for iterating through the
* results of a runnable object.
*
* The default runnable iterates the iterator, and calls an iter_action (see
* below) for each returned result.
*
* @param it The iterator to be iterated by the runnable.
*/
ecs_run_action_t :: proc "c" (it: ^ecs_iter_t)

/** Function prototype for iterables.
* A system may invoke a callback multiple times, typically once for each
* matched table.
*
* @param it The iterator containing the data for the current match.
*/
ecs_iter_action_t :: proc "c" (it: ^ecs_iter_t)

/** Function prototype for iterating an iterator.
* Stored inside initialized iterators. This allows an application to iterate
* an iterator without needing to know what created it.
*
* @param it The iterator to iterate.
* @return True if iterator has more results, false if not.
*/
ecs_iter_next_action_t :: proc "c" (it: ^ecs_iter_t) -> bool

/** Function prototype for freeing an iterator.
* Free iterator resources.
*
* @param it The iterator to free.
*/
ecs_iter_fini_action_t :: proc "c" (it: ^ecs_iter_t)

/** Callback used for comparing components. */
ecs_order_by_action_t :: proc "c" (e1: ecs_entity_t, ptr1: rawptr, e2: ecs_entity_t, ptr2: rawptr) -> i32

/** Callback used for sorting the entire table of components. */
ecs_sort_table_action_t :: proc "c" (world: ^ecs_world_t, table: ^ecs_table_t, entities: ^ecs_entity_t, ptr: rawptr, size: i32, lo: i32, hi: i32, order_by: ecs_order_by_action_t)

/** Callback used for grouping tables in a query. */
ecs_group_by_action_t :: proc "c" (world: ^ecs_world_t, table: ^ecs_table_t, group_id: ecs_id_t, ctx: rawptr) -> u64

/** Callback invoked when a query creates a new group. */
ecs_group_create_action_t :: proc "c" (world: ^ecs_world_t, group_id: u64, group_by_ctx: rawptr /* from ecs_query_desc_t */) -> rawptr

/** Callback invoked when a query deletes an existing group. */
ecs_group_delete_action_t :: proc "c" (world: ^ecs_world_t, group_id: u64, group_ctx: rawptr, group_by_ctx: rawptr /* from ecs_query_desc_t */)

/** Initialization action for modules. */
ecs_module_action_t :: proc "c" (world: ^ecs_world_t)

/** Action callback on world exit. */
ecs_fini_action_t :: proc "c" (world: ^ecs_world_t, ctx: rawptr)

/** Function to clean up context data. */
ecs_ctx_free_t :: proc "c" (ctx: rawptr)

/** Callback used for sorting values. */
ecs_compare_action_t :: proc "c" (ptr1: rawptr, ptr2: rawptr) -> i32

/** Callback used for hashing values. */
ecs_hash_value_action_t :: proc "c" (ptr: rawptr) -> u64

/** Constructor/destructor callback. */
ecs_xtor_t :: proc "c" (ptr: rawptr, count: i32, type_info: ^ecs_type_info_t)

/** Copy is invoked when a component is copied into another component. */
ecs_copy_t :: proc "c" (dst_ptr: rawptr, src_ptr: rawptr, count: i32, type_info: ^ecs_type_info_t)

/** Move is invoked when a component is moved to another component. */
ecs_move_t :: proc "c" (dst_ptr: rawptr, src_ptr: rawptr, count: i32, type_info: ^ecs_type_info_t)

/** Compare hook to compare component instances. */
ecs_cmp_t :: proc "c" (a_ptr: rawptr, b_ptr: rawptr, type_info: ^ecs_type_info_t) -> i32

/** Equals operator hook. */
ecs_equals_t :: proc "c" (a_ptr: rawptr, b_ptr: rawptr, type_info: ^ecs_type_info_t) -> bool

/** Destructor function for poly objects. */
flecs_poly_dtor_t :: proc "c" (poly: ^ecs_poly_t)

/** Specify read/write access for term. */
ecs_inout_kind_t :: enum i32 {
	InOutDefault = 0, /**< InOut for regular terms, In for shared terms. */
	InOutNone    = 1, /**< Term is neither read nor written. */
	InOutFilter  = 2, /**< Same as InOutNone + prevents term from triggering observers. */
	InOut        = 3, /**< Term is both read and written. */
	In           = 4, /**< Term is only read. */
	Out          = 5, /**< Term is only written. */
}

/** Specify operator for term. */
ecs_oper_kind_t :: enum i32 {
	And      = 0, /**< The term must match. */
	Or       = 1, /**< One of the terms in an or chain must match. */
	Not      = 2, /**< The term must not match. */
	Optional = 3, /**< The term may match. */
	AndFrom  = 4, /**< Term must match all components from term ID. */
	OrFrom   = 5, /**< Term must match at least one component from term ID. */
	NotFrom  = 6, /**< Term must match none of the components from term ID. */
}

/** Specify cache policy for query. */
ecs_query_cache_kind_t :: enum i32 {
	Default = 0, /**< Behavior determined by query creation context. */
	Auto    = 1, /**< Cache query terms that are cacheable. */
	All     = 2, /**< Require that all query terms can be cached. */
	None    = 3, /**< No caching. */
}

/** Term ID flags. */

/** Match on self.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsSelf                       :: (1<<63)

/** Match by traversing upwards.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsUp                         :: (1<<62)

/** Traverse relationship transitively.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsTrav                       :: (1<<61)

/** Sort results breadth-first.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsCascade                    :: (1<<60)

/** Iterate groups in descending order.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsDesc                       :: (1<<59)

/** Term ID is a variable.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsIsVariable                 :: (1<<58)

/** Term ID is an entity.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsIsEntity                   :: (1<<57)

/** Term ID is a name (don't attempt to look up as an entity).
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsIsName                     :: (1<<56)

/** All term traversal flags.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsTraverseFlags              :: (EcsSelf|EcsUp|EcsTrav|EcsCascade|EcsDesc)

/** All term reference kind flags.
* Can be combined with other term flags on the ecs_term_ref_t::id field.
* \ingroup queries
*/
EcsTermRefFlags               :: (EcsTraverseFlags|EcsIsVariable|EcsIsEntity|EcsIsName)

/** Type that describes a reference to an entity or variable in a term. */
ecs_term_ref_t :: struct {
	id:   ecs_entity_t, /**< Entity ID. If left to 0 and flags do not
                                 * specify whether the ID is an entity or a variable,
                                 * the ID will be initialized to #EcsThis.
                                 * To explicitly set the ID to 0, leave the ID
                                 * member to 0 and set #EcsIsEntity in flags. */
	name: cstring,      /**< Name. This can be either the variable name
                                 * (when the #EcsIsVariable flag is set) or an
                                 * entity name. When ecs_term_t::move is true,
                                 * the API assumes ownership over the string and
                                 * will free it when the term is destroyed. */
}

/** Type that describes a term (single element in a query). */
ecs_term_t :: struct {
	id:          ecs_id_t,       /**< Component ID to be matched by term. Can be
                                 * set directly, or will be populated from the
                                 * first/second members, which provide more
                                 * flexibility. */
	src:         ecs_term_ref_t, /**< Source of term. */
	first:       ecs_term_ref_t, /**< Component or first element of pair. */
	second:      ecs_term_ref_t, /**< Second element of pair. */
	trav:        ecs_entity_t,   /**< Relationship to traverse when looking for the
                                 * component. The relationship must have
                                 * the `Traversable` property. Default is `IsA`. */
	inout:       i16,            /**< Access to contents matched by term. */
	oper:        i16,            /**< Operator of term. */
	field_index: i8,             /**< Index of the field for the term in the iterator. */
	flags_:      ecs_flags16_t,  /**< Flags that help evaluation, set by ecs_query_init(). */
}

/** Queries are lists of constraints (terms) that match entities.
* Created with ecs_query_init().
*/
ecs_query_t :: struct {
	hdr:          ecs_header_t,  /**< Object header. */
	terms:        ^ecs_term_t,   /**< Query terms. */
	sizes:        ^i32,          /**< Component sizes. Indexed by field. */
	ids:          ^ecs_id_t,     /**< Component ids. Indexed by field. */
	bloom_filter: u64,           /**< Bitmask used to quickly discard tables. */
	flags:        ecs_flags32_t, /**< Query flags. */
	var_count:    i8,            /**< Number of query variables. */
	term_count:   i8,            /**< Number of query terms. */
	field_count:  i8,            /**< Number of fields returned by the query. */

	/** Bitmasks for quick field information lookups. */
	fixed_fields:           ecs_flags32_t,          /**< Fields with a fixed source. */
	var_fields:             ecs_flags32_t,          /**< Fields with non-$this variable source. */
	static_id_fields:       ecs_flags32_t,          /**< Fields with a static (component) id. */
	data_fields:            ecs_flags32_t,          /**< Fields that have data. */
	write_fields:           ecs_flags32_t,          /**< Fields that write data. */
	read_fields:            ecs_flags32_t,          /**< Fields that read data. */
	row_fields:             ecs_flags32_t,          /**< Fields that must be acquired with field_at. */
	shared_readonly_fields: ecs_flags32_t,          /**< Fields that don't write shared data. */
	set_fields:             ecs_flags32_t,          /**< Fields that will be set. */
	cache_kind:             ecs_query_cache_kind_t, /**< Caching policy of the query. */
	vars:                   ^cstring,               /**< Array with variable names for the iterator. */
	ctx:                    rawptr,                 /**< User context to pass to callback. */
	binding_ctx:            rawptr,                 /**< Context to be used for language bindings. */
	entity:                 ecs_entity_t,           /**< Entity associated with query (optional). */
	real_world:             ^ecs_world_t,           /**< Actual world. */
	world:                  ^ecs_world_t,           /**< World or stage the query was created with. */
	eval_count:             i32,                    /**< Number of times the query is evaluated. */
}

/** An observer reacts to events matching a query.
* Created with ecs_observer_init().
*/
ecs_observer_t :: struct {
	hdr:   ecs_header_t, /**< Object header. */
	query: ^ecs_query_t, /**< Observer query. */

	/** Observer events. */
	events:            [8]ecs_entity_t,
	event_count:       i32,               /**< Number of events. */
	callback:          ecs_iter_action_t, /**< See ecs_observer_desc_t::callback. */
	run:               ecs_run_action_t,  /**< See ecs_observer_desc_t::run. */
	ctx:               rawptr,            /**< Observer context. */
	callback_ctx:      rawptr,            /**< Callback language binding context. */
	run_ctx:           rawptr,            /**< Run language binding context. */
	ctx_free:          ecs_ctx_free_t,    /**< Callback to free ctx. */
	callback_ctx_free: ecs_ctx_free_t,    /**< Callback to free callback_ctx. */
	run_ctx_free:      ecs_ctx_free_t,    /**< Callback to free run_ctx. */
	observable:        ^ecs_observable_t, /**< Observable for the observer. */
	world:             ^ecs_world_t,      /**< The world. */
	entity:            ecs_entity_t,      /**< Entity associated with the observer. */
}

/** @} */

/** Type that contains component lifecycle callbacks.
*
* @ingroup components
*/

/* Flags that can be used to check which hooks a type has set */
ECS_TYPE_HOOK_CTOR                   :: ((ecs_flags32_t)(10))
ECS_TYPE_HOOK_DTOR                   :: ((ecs_flags32_t)(11))
ECS_TYPE_HOOK_COPY                   :: ((ecs_flags32_t)(12))
ECS_TYPE_HOOK_MOVE                   :: ((ecs_flags32_t)(13))
ECS_TYPE_HOOK_COPY_CTOR              :: ((ecs_flags32_t)(14))
ECS_TYPE_HOOK_MOVE_CTOR              :: ((ecs_flags32_t)(15))
ECS_TYPE_HOOK_CTOR_MOVE_DTOR         :: ((ecs_flags32_t)(16))
ECS_TYPE_HOOK_MOVE_DTOR              :: ((ecs_flags32_t)(17))
ECS_TYPE_HOOK_CMP                    :: ((ecs_flags32_t)(18))
ECS_TYPE_HOOK_EQUALS                 :: ((ecs_flags32_t)(19))

/* Flags that can be used to set/check which hooks of a type are invalid */
ECS_TYPE_HOOK_CTOR_ILLEGAL           :: ((ecs_flags32_t)(110))
ECS_TYPE_HOOK_DTOR_ILLEGAL           :: ((ecs_flags32_t)(112))
ECS_TYPE_HOOK_COPY_ILLEGAL           :: ((ecs_flags32_t)(113))
ECS_TYPE_HOOK_MOVE_ILLEGAL           :: ((ecs_flags32_t)(114))
ECS_TYPE_HOOK_COPY_CTOR_ILLEGAL      :: ((ecs_flags32_t)(115))
ECS_TYPE_HOOK_MOVE_CTOR_ILLEGAL      :: ((ecs_flags32_t)(116))
ECS_TYPE_HOOK_CTOR_MOVE_DTOR_ILLEGAL :: ((ecs_flags32_t)(117))
ECS_TYPE_HOOK_MOVE_DTOR_ILLEGAL      :: ((ecs_flags32_t)(118))
ECS_TYPE_HOOK_CMP_ILLEGAL            :: ((ecs_flags32_t)(119))
ECS_TYPE_HOOK_EQUALS_ILLEGAL         :: ((ecs_flags32_t)(120))

/* Internal debug flag that indicates type hooks have been invoked */
ECS_TYPE_HOOK_IN_USE                 :: ((ecs_flags32_t)(121))

/* All valid hook flags */
ECS_TYPE_HOOKS :: (ECS_TYPE_HOOK_CTOR|ECS_TYPE_HOOK_DTOR|ECS_TYPE_HOOK_COPY|ECS_TYPE_HOOK_MOVE|ECS_TYPE_HOOK_COPY_CTOR|ECS_TYPE_HOOK_MOVE_CTOR|ECS_TYPE_HOOK_CTOR_MOVE_DTOR|ECS_TYPE_HOOK_MOVE_DTOR|ECS_TYPE_HOOK_CMP|ECS_TYPE_HOOK_EQUALS)

/* All invalid hook flags */
ECS_TYPE_HOOKS_ILLEGAL :: (ECS_TYPE_HOOK_CTOR_ILLEGAL|ECS_TYPE_HOOK_DTOR_ILLEGAL|ECS_TYPE_HOOK_COPY_ILLEGAL|ECS_TYPE_HOOK_MOVE_ILLEGAL|ECS_TYPE_HOOK_COPY_CTOR_ILLEGAL|ECS_TYPE_HOOK_MOVE_CTOR_ILLEGAL|ECS_TYPE_HOOK_CTOR_MOVE_DTOR_ILLEGAL|ECS_TYPE_HOOK_MOVE_DTOR_ILLEGAL|ECS_TYPE_HOOK_CMP_ILLEGAL|ECS_TYPE_HOOK_EQUALS_ILLEGAL)

ecs_type_hooks_t :: struct {
	ctor: ecs_xtor_t, /**< ctor. */
	dtor: ecs_xtor_t, /**< dtor. */
	copy: ecs_copy_t, /**< copy assignment. */
	move: ecs_move_t, /**< move assignment. */

	/** Ctor + copy. */
	copy_ctor: ecs_copy_t,

	/** Ctor + move. */
	move_ctor: ecs_move_t,

	/** Ctor + move + dtor (or move_ctor + dtor).
	* This combination is typically used when a component is moved from one
	* location to a new location, like when it is moved to a new table. If
	* not set explicitly, it will be derived from other callbacks. */
	ctor_move_dtor: ecs_move_t,

	/** Move + dtor.
	* This combination is typically used when a component is moved from one
	* location to an existing location, like what happens during a remove. If
	* not set explicitly, it will be derived from other callbacks. */
	move_dtor: ecs_move_t,

	/** Compare hook. */
	cmp: ecs_cmp_t,

	/** Equals hook. */
	equals: ecs_equals_t,

	/** Hook flags.
	* Indicates which hooks are set for the type, and which hooks are illegal.
	* When an ILLEGAL flag is set when calling ecs_set_hooks(), a hook callback
	* will be set that panics when called. */
	flags: ecs_flags32_t,

	/** Callback that is invoked when an instance of a component is added. This
	* callback is invoked before observers are invoked. */
	on_add: ecs_iter_action_t,

	/** Callback that is invoked when an instance of the component is set. This
	* callback is invoked before observers are invoked, and enables the component
	* to respond to changes on itself before others can. */
	on_set: ecs_iter_action_t,

	/** Callback that is invoked when an instance of the component is removed.
	* This callback is invoked after the observers are invoked, and before the
	* destructor is invoked. */
	on_remove: ecs_iter_action_t,

	/** Callback that is invoked with the existing and new value before the
	* value is assigned. Invoked after on_add and before on_set. Registering
	* an on_replace hook prevents using operations that return a mutable
	* pointer to the component, like get_mut(), ensure(), and emplace(). */
	on_replace:         ecs_iter_action_t,
	ctx:                rawptr,         /**< User-defined context. */
	binding_ctx:        rawptr,         /**< Language binding context. */
	lifecycle_ctx:      rawptr,         /**< Component lifecycle context (see meta addon). */
	ctx_free:           ecs_ctx_free_t, /**< Callback to free ctx. */
	binding_ctx_free:   ecs_ctx_free_t, /**< Callback to free binding_ctx. */
	lifecycle_ctx_free: ecs_ctx_free_t, /**< Callback to free lifecycle_ctx. */
}

/** Type that contains component information (passed to ctors/dtors/...).
*
* @ingroup components
*/
ecs_type_info_t :: struct {
	size:      ecs_size_t,       /**< Size of the type. */
	alignment: ecs_size_t,       /**< Alignment of the type. */
	hooks:     ecs_type_hooks_t, /**< Type hooks. */
	component: ecs_entity_t,     /**< Handle to component (do not set). */
	name:      cstring,          /**< Type name. */
}

ecs_data_t              :: struct {}
ecs_query_cache_match_t :: struct {}
ecs_query_cache_group_t :: struct {}

/** All observers for a specific event. */
ecs_event_record_t :: struct {
	_any:          ^ecs_event_id_record_t,
	wildcard:      ^ecs_event_id_record_t,
	wildcard_pair: ^ecs_event_id_record_t,
	event_ids:     ecs_map_t, /* map<id, ecs_event_id_record_t> */
	event:         ecs_entity_t,
}

ecs_event_id_record_t :: struct {}

ecs_observable_t :: struct {
	on_add:           ecs_event_record_t,
	on_remove:        ecs_event_record_t,
	on_set:           ecs_event_record_t,
	on_wildcard:      ecs_event_record_t,
	events:           ecs_sparse_t, /* sparse<event, ecs_event_record_t> */
	global_observers: ecs_vec_t,    /* vector<ecs_observable_t> */
	last_observer_id: u64,
}

/** Range in a table. */
ecs_table_range_t :: struct {
	table:  ^ecs_table_t,
	offset: i32, /* Leave both members at 0 to cover the entire table. */
	count:  i32,
}

/** Value of a query variable. */
ecs_var_t :: struct {
	range:  ecs_table_range_t, /* Set when variable stores a range of entities. */
	entity: ecs_entity_t,      /* Set when variable stores a single entity. */
}

/** Cached reference. */
ecs_ref_t :: struct {
	entity:             ecs_entity_t, /* Entity. */
	table_id:           u64,          /* Table ID for detecting ABA issues. */
	table_version_fast: u32,          /* Fast change detection with false positives. */
	table_version:      u16,          /* Change detection. */
	ptr:                rawptr,       /* Cached component pointer. */
	id:                 ecs_entity_t, /* Component ID (debug only, used for asserts). */
}

/* Page-iterator-specific data. */
ecs_page_iter_t :: struct {
	offset:    i32,
	limit:     i32,
	remaining: i32,
}

/* Worker-iterator-specific data. */
ecs_worker_iter_t :: struct {
	index: i32,
	count: i32,
}

/* Convenience struct to iterate a table array for an ID. */
ecs_table_cache_iter_t :: struct {
	cur, next:  ^ecs_table_cache_hdr_t,
	iter_fill:  bool,
	iter_empty: bool,
}

/** Each iterator. */
ecs_each_iter_t :: struct {
	it: ecs_table_cache_iter_t,

	/* Storage for iterator fields. */
	ids:     ecs_id_t,
	sources: ecs_entity_t,
	sizes:   ecs_size_t,
	columns: i16,
	trs:     ^ecs_table_record_t,
}

ecs_query_op_profile_t :: struct {
	count: [2]i32, /* 0 = enter, 1 = redo */
}

/** Query iterator. */
ecs_query_iter_t :: struct {
	vars:       ^ecs_var_t,          /* Variable storage. */
	query_vars: ^ecs_query_var_t,    /* Query variable metadata. */
	ops:        ^ecs_query_op_t,     /* Query plan operations. */
	op_ctx:     ^ecs_query_op_ctx_t, /* Operation-specific state. */
	written:    ^u64,

	/* Cached iteration. */
	group:             ^ecs_query_cache_group_t, /* Currently iterated group. */
	tables:            ^ecs_vec_t,               /* Currently iterated table vector (vec<ecs_query_cache_match_t>). */
	all_tables:        ^ecs_vec_t,               /* Different from .tables if iterating wildcard matches (vec<ecs_query_cache_match_t>). */
	elem:              ^ecs_query_cache_match_t, /* Current cache entry. */
	cur, all_cur:      i32,                      /* Indices into tables and all_tables. */
	profile:           ^ecs_query_op_profile_t,
	op:                i16,                      /* Currently iterated query plan operation (index into ops). */
	iter_single_group: bool,
}

ecs_query_var_t    :: struct {} /* Query variable metadata. */
ecs_query_op_t     :: struct {} /* Query plan operations. */
ecs_query_op_ctx_t :: struct {} /* Operation-specific state. */

/* Private iterator data. Used by iterator implementations to keep track of
* progress and to provide built-in storage. */
ecs_iter_private_t :: struct {
	iter: struct #raw_union {
		query:  ecs_query_iter_t,
		page:   ecs_page_iter_t,
		worker: ecs_worker_iter_t,
		each:   ecs_each_iter_t,
	}, /* Iterator-specific data. */

	entity_iter:  rawptr,              /* Query applied after matching a table. */
	stack_cursor: ^ecs_stack_cursor_t, /* Stack cursor to restore to. */
}

/* Data structures that store the command queue. */
ecs_commands_t :: struct {
	queue:   ecs_vec_t,
	stack:   ecs_stack_t,  /* Temp memory used by deferred commands. */
	entries: ecs_sparse_t, /* <entity, op_entry_t> - command batching. */
}

/** This is the largest possible component ID. Components, for the most part,
* occupy the same ID range as entities, however they are not allowed to overlap
* with (8) bits reserved for ID flags. */
ECS_MAX_COMPONENT_ID :: (~((u32)(ECS_ID_FLAGS_MASK>>32)))

/** The maximum number of nested function calls before the core will throw a
* cycle-detected error. */
ECS_MAX_RECURSION :: (512)

/** Maximum length of a parser token (used by parser-related addons). */
ECS_MAX_TOKEN_SIZE :: (256)

@(default_calling_convention="c")
foreign lib {
	/** Convert a C module name into a path.
	* This operation converts a PascalCase name to a path, for example, MyFooModule
	* into my.foo.module.
	*
	* @param c_name The C module name.
	* @return The path.
	*/
	flecs_module_path_from_c :: proc(c_name: cstring) -> cstring ---

	/** Constructor that zero-initializes a component value.
	*
	* @param ptr Pointer to the value.
	* @param count Number of elements to construct.
	* @param type_info Type info for the component.
	*/
	flecs_default_ctor :: proc(ptr: rawptr, count: i32, type_info: ^ecs_type_info_t) ---

	/* Wrapper functions for invoking type hooks with fallback behavior. */
	flecs_type_info_ctor           :: proc(ptr: rawptr, count: i32, type_info: ^ecs_type_info_t) -> bool ---
	flecs_type_info_dtor           :: proc(ptr: rawptr, count: i32, type_info: ^ecs_type_info_t) -> bool ---
	flecs_type_info_copy           :: proc(dst: rawptr, src: rawptr, count: i32, type_info: ^ecs_type_info_t) ---
	flecs_type_info_move           :: proc(dst: rawptr, src: rawptr, count: i32, type_info: ^ecs_type_info_t) ---
	flecs_type_info_copy_ctor      :: proc(dst: rawptr, src: rawptr, count: i32, type_info: ^ecs_type_info_t) ---
	flecs_type_info_move_ctor      :: proc(dst: rawptr, src: rawptr, count: i32, type_info: ^ecs_type_info_t) ---
	flecs_type_info_ctor_move_dtor :: proc(dst: rawptr, src: rawptr, count: i32, type_info: ^ecs_type_info_t) ---
	flecs_type_info_move_dtor      :: proc(dst: rawptr, src: rawptr, count: i32, type_info: ^ecs_type_info_t) ---
	flecs_type_info_cmp            :: proc(a: rawptr, b: rawptr, type_info: ^ecs_type_info_t) -> i32 ---
	flecs_type_info_equals         :: proc(a: rawptr, b: rawptr, type_info: ^ecs_type_info_t) -> bool ---

	/** Create an allocated string from a format.
	*
	* @param fmt The format string.
	* @param args Format arguments.
	* @return The formatted string.
	*/
	flecs_vasprintf :: proc(fmt: cstring, args: c.va_list) -> cstring ---

	/** Create an allocated string from a format.
	*
	* @param fmt The format string.
	* @return The formatted string.
	*/
	flecs_asprintf :: proc(fmt: cstring, #c_vararg _: ..any) -> cstring ---

	/** Write an escaped character.
	* Write a character to an output string, inserting an escape character if necessary.
	*
	* @param out The string to write the character to.
	* @param in The input character.
	* @param delimiter The delimiter used (for example, '"').
	* @return Pointer to the character after the last one written.
	*/
	flecs_chresc :: proc(out: cstring, _in: i8, delimiter: i8) -> cstring ---

	/** Parse an escaped character.
	* Parse a character with a potential escape sequence.
	*
	* @param in Pointer to a character in the input string.
	* @param out Output string.
	* @return Pointer to the character after the last one read.
	*/
	flecs_chrparse :: proc(_in: cstring, out: cstring) -> cstring ---

	/** Write an escaped string.
	* Write an input string to an output string, escaping characters where necessary.
	* To determine the size of the output string, call the operation with a NULL
	* argument for 'out', and use the returned size to allocate a string that is
	* large enough.
	*
	* @param out Pointer to output string (may be NULL).
	* @param size Maximum number of characters written to output.
	* @param delimiter The delimiter used (for example, '"').
	* @param in The input string.
	* @return The number of characters that (would) have been written.
	*/
	flecs_stresc :: proc(out: cstring, size: ecs_size_t, delimiter: i8, _in: cstring) -> ecs_size_t ---

	/** Return an escaped string.
	* Same as flecs_stresc(), but returns an
	* allocated string of the right size.
	*
	* @param delimiter The delimiter used (for example, '"').
	* @param in The input string.
	* @return The escaped string.
	*/
	flecs_astresc :: proc(delimiter: i8, _in: cstring) -> cstring ---

	/** Skip whitespace and newline characters.
	* This function skips whitespace characters.
	*
	* @param ptr Pointer to (potential) whitespace to skip.
	* @return Pointer to the next non-whitespace character.
	*/
	flecs_parse_ws_eol :: proc(ptr: cstring) -> cstring ---

	/** Parse a digit.
	* This function will parse until the first non-digit character is found. The
	* provided expression must contain at least one digit character.
	*
	* @param ptr The expression to parse.
	* @param token The output buffer.
	* @param token_size The size of the output buffer.
	* @return Pointer to the first non-digit character.
	*/
	flecs_parse_digit :: proc(ptr: cstring, token: cstring, token_size: i32) -> cstring ---

	/* Convert an identifier to snake case. */
	flecs_to_snake_case :: proc(str: cstring) -> cstring ---
}

/* Suspend and resume read-only state. To fully support implicit registration of
* components, it should be possible to register components while the world is
* in read-only mode. It is not uncommon that a component is used first from
* within a system, which is often run while in read-only mode.
*
* Suspending read-only mode is only allowed when the world is not multithreaded.
* When a world is multithreaded, it is not safe to (even temporarily) leave
* read-only mode, so a multithreaded application should always explicitly
* register components in advance.
*
* These operations also suspend deferred mode.
*
* Functions are public to support language bindings.
*/
ecs_suspend_readonly_state_t :: struct {
	is_readonly:  bool,
	is_deferred:  bool,
	cmd_flushing: bool,
	defer_count:  i32,
	scope:        ecs_entity_t,
	with:         ecs_entity_t,
	cmd_stack:    [2]ecs_commands_t,
	cmd:          ^ecs_commands_t,
	stage:        ^ecs_stage_t,
}

@(default_calling_convention="c")
foreign lib {
	flecs_suspend_readonly :: proc(world: ^ecs_world_t, state: ^ecs_suspend_readonly_state_t) -> ^ecs_world_t ---
	flecs_resume_readonly  :: proc(world: ^ecs_world_t, state: ^ecs_suspend_readonly_state_t) ---

	/** Return the number of observed entities in a table.
	* This operation is public to support test cases.
	*
	* @param table The table.
	* @return The number of observed entities.
	*/
	flecs_table_observed_count :: proc(table: ^ecs_table_t) -> i32 ---

	/** Print a backtrace to the specified stream.
	*
	* @param stream The stream to use for printing the backtrace.
	*/
	flecs_dump_backtrace :: proc(stream: rawptr) ---

	/** Increase the refcount of a poly object.
	*
	* @param poly The poly object.
	* @return The refcount after incrementing.
	*/
	flecs_poly_claim_ :: proc(poly: ^ecs_poly_t) -> i32 ---

	/** Decrease the refcount of a poly object.
	*
	* @param poly The poly object.
	* @return The refcount after decrementing.
	*/
	flecs_poly_release_ :: proc(poly: ^ecs_poly_t) -> i32 ---

	/** Return the refcount of a poly object.
	*
	* @param poly The poly object.
	* @return Refcount of the poly object.
	*/
	flecs_poly_refcount :: proc(poly: ^ecs_poly_t) -> i32 ---

	/** Get an unused index for the static world-local component ID array.
	* This operation returns an unused index for the world-local component ID
	* array. This index can be used by language bindings to obtain a component ID.
	*
	* @return Unused index for component ID array.
	*/
	flecs_component_ids_index_get :: proc() -> i32 ---

	/** Get a world-local component ID.
	*
	* @param world The world.
	* @param index Component ID array index.
	* @return The component ID.
	*/
	flecs_component_ids_get :: proc(world: ^ecs_world_t, index: i32) -> ecs_entity_t ---

	/** Get an alive world-local component ID.
	* Same as flecs_component_ids_get(), but returns 0 if the component is no
	* longer alive.
	*
	* @param world The world.
	* @param index Component ID array index.
	* @return The component ID.
	*/
	flecs_component_ids_get_alive :: proc(world: ^ecs_world_t, index: i32) -> ecs_entity_t ---

	/** Set a world-local component ID.
	*
	* @param world The world.
	* @param index Component ID array index.
	* @param id The component ID.
	*/
	flecs_component_ids_set :: proc(world: ^ecs_world_t, index: i32, id: ecs_entity_t) ---

	/** Query iterator function for trivially cached queries.
	* This operation can be called if an iterator matches the conditions for
	* trivial iteration.
	*
	* @param it The query iterator.
	* @return Whether the query has more results.
	*/
	flecs_query_trivial_cached_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Check if the current thread has exclusive access to the world.
	* This operation checks if the current thread is allowed to access the world.
	* The operation is called by internal functions before mutating the world, and
	* will panic if the current thread does not have exclusive access to the world.
	*
	* Exclusive access is controlled by the ecs_exclusive_access_begin() and
	* ecs_exclusive_access_end() operations.
	*
	* This operation is public so that it shows up in stack traces, but code such
	* as language bindings or wrappers could also use it to verify that the world
	* is accessed from the correct thread.
	*
	* @param world The world.
	*/
	flecs_check_exclusive_world_access_write :: proc(world: ^ecs_world_t) ---

	/** Same as flecs_check_exclusive_world_access_write(), but for read access.
	*
	* @param world The world.
	*/
	flecs_check_exclusive_world_access_read :: proc(world: ^ecs_world_t) ---

	/** End deferred mode (executes commands when stage->defer becomes 0). */
	flecs_defer_end :: proc(world: ^ecs_world_t, stage: ^ecs_stage_t) -> bool ---
}

/** A bucket in the hashmap, storing parallel key and value vectors. */
ecs_hm_bucket_t :: struct {
	keys:   ecs_vec_t, /**< Vector of keys. */
	values: ecs_vec_t, /**< Vector of values. */
}

/** A hashmap that supports variable-sized keys and values. */
ecs_hashmap_t :: struct {
	hash:       ecs_hash_value_action_t, /**< Hash function for keys. */
	compare:    ecs_compare_action_t,    /**< Compare function for keys. */
	key_size:   ecs_size_t,              /**< Size of key type. */
	value_size: ecs_size_t,              /**< Size of value type. */
	impl:       ecs_map_t,               /**< Underlying map implementation. */
}

/** Iterator for a hashmap. */
flecs_hashmap_iter_t :: struct {
	it:     ecs_map_iter_t,   /**< Underlying map iterator. */
	bucket: ^ecs_hm_bucket_t, /**< Current bucket. */
	index:  i32,              /**< Current index within the bucket. */
}

/** Result of a hashmap ensure operation. */
flecs_hashmap_result_t :: struct {
	key:   rawptr, /**< Pointer to the key. */
	value: rawptr, /**< Pointer to the value. */
	hash:  u64,    /**< Hash value of the key. */
}

@(default_calling_convention="c")
foreign lib {
	/** Initialize a hashmap.
	*
	* @param hm The hashmap to initialize.
	* @param key_size The size of the key type.
	* @param value_size The size of the value type.
	* @param hash The hash function.
	* @param compare The compare function.
	* @param allocator The allocator.
	*/
	flecs_hashmap_init_ :: proc(hm: ^ecs_hashmap_t, key_size: ecs_size_t, value_size: ecs_size_t, hash: ecs_hash_value_action_t, compare: ecs_compare_action_t, allocator: ^ecs_allocator_t) ---

	/** Deinitialize a hashmap.
	*
	* @param map The hashmap to deinitialize.
	*/
	flecs_hashmap_fini :: proc(_map: ^ecs_hashmap_t) ---

	/** Get a value from the hashmap.
	*
	* @param map The hashmap.
	* @param key_size The size of the key type.
	* @param key The key to look up.
	* @param value_size The size of the value type.
	* @return Pointer to the value, or NULL if not found.
	*/
	flecs_hashmap_get_ :: proc(_map: ^ecs_hashmap_t, key_size: ecs_size_t, key: rawptr, value_size: ecs_size_t) -> rawptr ---

	/** Ensure a key exists in the hashmap, inserting if necessary.
	*
	* @param map The hashmap.
	* @param key_size The size of the key type.
	* @param key The key to ensure.
	* @param value_size The size of the value type.
	* @return A result containing pointers to the key, value, and hash.
	*/
	flecs_hashmap_ensure_ :: proc(_map: ^ecs_hashmap_t, key_size: ecs_size_t, key: rawptr, value_size: ecs_size_t) -> flecs_hashmap_result_t ---

	/** Set a key-value pair in the hashmap.
	*
	* @param map The hashmap.
	* @param key_size The size of the key type.
	* @param key The key.
	* @param value_size The size of the value type.
	* @param value The value to set.
	*/
	flecs_hashmap_set_ :: proc(_map: ^ecs_hashmap_t, key_size: ecs_size_t, key: rawptr, value_size: ecs_size_t, value: rawptr) ---

	/** Remove a key from the hashmap.
	*
	* @param map The hashmap.
	* @param key_size The size of the key type.
	* @param key The key to remove.
	* @param value_size The size of the value type.
	*/
	flecs_hashmap_remove_ :: proc(_map: ^ecs_hashmap_t, key_size: ecs_size_t, key: rawptr, value_size: ecs_size_t) ---

	/** Remove a key from the hashmap using a precomputed hash.
	*
	* @param map The hashmap.
	* @param key_size The size of the key type.
	* @param key The key to remove.
	* @param value_size The size of the value type.
	* @param hash The precomputed hash of the key.
	*/
	flecs_hashmap_remove_w_hash_ :: proc(_map: ^ecs_hashmap_t, key_size: ecs_size_t, key: rawptr, value_size: ecs_size_t, hash: u64) ---

	/** Get a bucket from the hashmap by hash value.
	*
	* @param map The hashmap.
	* @param hash The hash value.
	* @return The bucket, or NULL if not found.
	*/
	flecs_hashmap_get_bucket :: proc(_map: ^ecs_hashmap_t, hash: u64) -> ^ecs_hm_bucket_t ---

	/** Remove an entry from a hashmap bucket by index.
	*
	* @param map The hashmap.
	* @param bucket The bucket.
	* @param hash The hash value.
	* @param index The index within the bucket to remove.
	*/
	flecs_hm_bucket_remove :: proc(_map: ^ecs_hashmap_t, bucket: ^ecs_hm_bucket_t, hash: u64, index: i32) ---

	/** Copy a hashmap.
	*
	* @param dst The destination hashmap.
	* @param src The source hashmap.
	*/
	flecs_hashmap_copy :: proc(dst: ^ecs_hashmap_t, src: ^ecs_hashmap_t) ---

	/** Create an iterator for a hashmap.
	*
	* @param map The hashmap to iterate.
	* @return The iterator.
	*/
	flecs_hashmap_iter :: proc(_map: ^ecs_hashmap_t) -> flecs_hashmap_iter_t ---

	/** Get the next element from a hashmap iterator.
	*
	* @param it The hashmap iterator.
	* @param key_size The size of the key type.
	* @param key_out Output parameter for the key.
	* @param value_size The size of the value type.
	* @return Pointer to the value, or NULL if no more elements.
	*/
	flecs_hashmap_next_ :: proc(it: ^flecs_hashmap_iter_t, key_size: ecs_size_t, key_out: rawptr, value_size: ecs_size_t) -> rawptr ---
}

/** Record for entity index. */
ecs_record_t :: struct {
	table: ^ecs_table_t, /**< Identifies a type (and table) in the world. */
	row:   u32,          /**< Table row of the entity. */
	dense: i32,          /**< Index in dense array of entity index. */
}

/** Header for table cache elements. */
ecs_table_cache_hdr_t :: struct {
	cr:         ^ecs_component_record_t, /**< Component record for component. */
	table:      ^ecs_table_t,            /**< Table associated with element. */
	prev, next: ^ecs_table_cache_hdr_t,  /**< Previous and next elements for ID in table cache. */
}

/** Record that stores the location of a component in a table.
* Table records are registered with component records, which allows for quickly
* finding all tables for a specific component. */
ecs_table_record_t :: struct {
	hdr:    ecs_table_cache_hdr_t, /**< Table cache header. */
	index:  i16,                   /**< First type index where ID occurs in table. */
	count:  i16,                   /**< Number of times ID occurs in table. */
	column: i16,                   /**< First column index where ID occurs. */
}

/** Type that contains information about which components got added or removed on
* a table edge. */
ecs_table_diff_t :: struct {
	added:         ecs_type_t, /* Components added between tables. */
	removed:       ecs_type_t, /* Components removed between tables. */
	added_flags:   ecs_flags32_t,
	removed_flags: ecs_flags32_t,
}

/* Tracks which and how many non-fragmenting children are stored in a table for a parent. */
ecs_parent_record_t :: struct {
	entity: u32, /* If the table only contains a single entity for the parent, this will contain the entity ID (without generation). */
	count:  i32, /* The number of children for a parent in the table. */
}

@(default_calling_convention="c")
foreign lib {
	/** Find the record for an entity.
	* An entity record contains the table and row for the entity.
	*
	* To use ecs_record_t::row as the record in the table, use:
	*   ECS_RECORD_TO_ROW(r->row)
	*
	* This removes potential entity bitflags from the row field.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The record, NULL if the entity does not exist.
	*/
	ecs_record_find :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> ^ecs_record_t ---

	/** Get the entity corresponding to a record.
	* This operation only works for entities that are not empty.
	*
	* @param record The record for which to obtain the entity ID.
	* @return The entity ID for the record.
	*/
	ecs_record_get_entity :: proc(record: ^ecs_record_t) -> ecs_entity_t ---

	/** Begin exclusive write access to an entity.
	* This operation provides safe exclusive access to the components of an entity
	* without the overhead of deferring operations.
	*
	* When this operation is called simultaneously for the same entity more than
	* once, it will throw an assert. Note that for this to happen, asserts must be
	* enabled. It is up to the application to ensure that access is exclusive, for
	* example, by using a read-write mutex.
	*
	* Exclusive access is enforced at the table level, so only one entity can be
	* exclusively accessed per table. The exclusive access check is thread-safe.
	*
	* This operation must be followed up with ecs_write_end().
	*
	* @param world The world.
	* @param entity The entity.
	* @return A record to the entity.
	*/
	ecs_write_begin :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> ^ecs_record_t ---

	/** End exclusive write access to an entity.
	* This operation ends exclusive access, and must be called after
	* ecs_write_begin().
	*
	* @param record Record to the entity.
	*/
	ecs_write_end :: proc(record: ^ecs_record_t) ---

	/** Begin read access to an entity.
	* This operation provides safe read access to the components of an entity.
	* Multiple simultaneous reads are allowed per entity.
	*
	* This operation ensures that code attempting to mutate the entity's table will
	* throw an assert. Note that for this to happen, asserts must be enabled. It is
	* up to the application to ensure that this does not happen, for example, by
	* using a read-write mutex.
	*
	* This operation does *not* provide the same guarantees as a read-write mutex,
	* as it is possible to call ecs_read_begin() after calling ecs_write_begin(). It is
	* up to the application to ensure that this does not happen.
	*
	* This operation must be followed up with ecs_read_end().
	*
	* @param world The world.
	* @param entity The entity.
	* @return A record to the entity.
	*/
	ecs_read_begin :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> ^ecs_record_t ---

	/** End read access to an entity.
	* This operation ends read access, and must be called after ecs_read_begin().
	*
	* @param record Record to the entity.
	*/
	ecs_read_end :: proc(record: ^ecs_record_t) ---

	/** Get a component from an entity record.
	* This operation returns a pointer to a component for the entity
	* associated with the provided record. For safe access to the component, obtain
	* the record with ecs_read_begin() or ecs_write_begin().
	*
	* Obtaining a component from a record is faster than obtaining it from the
	* entity handle, as it reduces the number of lookups required.
	*
	* @param world The world.
	* @param record Record to the entity.
	* @param id The (component) ID.
	* @return Pointer to component, or NULL if entity does not have the component.
	*
	* @see ecs_record_ensure_id()
	*/
	ecs_record_get_id :: proc(world: ^ecs_world_t, record: ^ecs_record_t, id: ecs_id_t) -> rawptr ---

	/** Same as ecs_record_get_id(), but returns a mutable pointer.
	* For safe access to the component, obtain the record with ecs_write_begin().
	*
	* @param world The world.
	* @param record Record to the entity.
	* @param id The (component) ID.
	* @return Pointer to component, or NULL if entity does not have the component.
	*/
	ecs_record_ensure_id :: proc(world: ^ecs_world_t, record: ^ecs_record_t, id: ecs_id_t) -> rawptr ---

	/** Test if the entity for a record has a (component) ID.
	*
	* @param world The world.
	* @param record Record to the entity.
	* @param id The (component) ID.
	* @return Whether the entity has the component.
	*/
	ecs_record_has_id :: proc(world: ^ecs_world_t, record: ^ecs_record_t, id: ecs_id_t) -> bool ---

	/** Get a component pointer from a column and record.
	* This returns a pointer to the component using a table column index. The
	* table's column index can be found with ecs_table_get_column_index().
	*
	* Usage:
	* @code
	* ecs_record_t *r = ecs_record_find(world, entity);
	* int32_t column = ecs_table_get_column_index(world, table, ecs_id(Position));
	* Position *ptr = ecs_record_get_by_column(r, column, sizeof(Position));
	* @endcode
	*
	* @param record The record.
	* @param column The column index in the entity's table.
	* @param size The component size.
	* @return The component pointer.
	*/
	ecs_record_get_by_column :: proc(record: ^ecs_record_t, column: i32, size: c.size_t) -> rawptr ---

	/** Get the component record for a component ID.
	*
	* @param world The world.
	* @param id The component ID.
	* @return The component record, or NULL if it doesn't exist.
	*/
	flecs_components_get :: proc(world: ^ecs_world_t, id: ecs_id_t) -> ^ecs_component_record_t ---

	/** Ensure a component record for a component ID.
	*
	* @param world The world.
	* @param id The component ID.
	* @return The new or existing component record.
	*/
	flecs_components_ensure :: proc(world: ^ecs_world_t, id: ecs_id_t) -> ^ecs_component_record_t ---

	/** Get the component ID from a component record.
	*
	* @param cr The component record.
	* @return The component ID.
	*/
	flecs_component_get_id :: proc(cr: ^ecs_component_record_t) -> ecs_id_t ---

	/** Get the component flags for a component.
	*
	* @param world The world.
	* @param id The component ID.
	* @return The flags for the component ID.
	*/
	flecs_component_get_flags :: proc(world: ^ecs_world_t, id: ecs_id_t) -> ecs_flags32_t ---

	/** Get the type info for a component record.
	*
	* @param cr The component record.
	* @return The type info struct, or NULL if the component is a tag.
	*/
	flecs_component_get_type_info :: proc(cr: ^ecs_component_record_t) -> ^ecs_type_info_t ---

	/** Find the table record for a component record.
	* This operation returns the table record for the table and component record if it
	* exists. If the record exists, it means the table has the component.
	*
	* @param cr The component record.
	* @param table The table.
	* @return The table record if the table has the component, or NULL if not.
	*/
	flecs_component_get_table :: proc(cr: ^ecs_component_record_t, table: ^ecs_table_t) -> ^ecs_table_record_t ---

	/** Get the parent record for a component and table.
	* A parent record stores how many children for a parent are stored in the
	* specified table. If the table only stores a single child, the parent record
	* will also store the entity ID of that child.
	*
	* This information is used by queries to determine whether an O(n) search
	* through the table is required to find all children for the parent. If the
	* table only contains a single child, the query can use
	* ecs_parent_record_t::entity directly, otherwise it has to do a scan.
	*
	* The component record specified to this function must be a ChildOf pair. Only
	* tables with children that use the non-fragmenting hierarchy storage will have
	* parent records.
	*
	* @param cr The ChildOf component record.
	* @param table The table to check the number of children for.
	* @return The parent record if it exists, NULL if it does not.
	*/
	flecs_component_get_parent_record :: proc(cr: ^ecs_component_record_t, table: ^ecs_table_t) -> ^ecs_parent_record_t ---

	/** Return the hierarchy depth for a component record.
	* The specified component record must be a ChildOf pair. This function does not
	* compute the depth, it just returns the precomputed depth that is updated
	* automatically when hierarchy changes happen.
	*
	* @param cr The ChildOf component record.
	* @return The depth of the parent's children in the hierarchy.
	*/
	flecs_component_get_childof_depth :: proc(cr: ^ecs_component_record_t) -> i32 ---

	/** Create a component record iterator.
	* A component record iterator iterates all tables for the specified component
	* record.
	*
	* The iterator should be used like this:
	*
	* @code
	* ecs_table_cache_iter_t it;
	* if (flecs_component_iter(cr, &it)) {
	*   const ecs_table_record_t *tr;
	*   while ((tr = flecs_component_next(&it))) {
	*     ecs_table_t *table = tr->hdr.table;
	*     // ...
	*   }
	* }
	* @endcode
	*
	* @param cr The component record.
	* @param iter_out Out parameter for the iterator.
	* @return True if there are results, false if there are no results.
	*/
	flecs_component_iter :: proc(cr: ^ecs_component_record_t, iter_out: ^ecs_table_cache_iter_t) -> bool ---

	/** Get the next table record for the iterator.
	* Returns the next table record, or NULL if there are no more results.
	*
	* @param iter The iterator.
	* @return The next table record, or NULL if there are no more results.
	*/
	flecs_component_next :: proc(iter: ^ecs_table_cache_iter_t) -> ^ecs_table_record_t ---
}

/** Struct returned by flecs_table_records(). */
ecs_table_records_t :: struct {
	array: ^ecs_table_record_t,
	count: i32,
}

@(default_calling_convention="c")
foreign lib {
	/** Get the table records.
	* This operation returns an array with all records for the specified table.
	*
	* @param table The table.
	* @return The table records for the table.
	*/
	flecs_table_records :: proc(table: ^ecs_table_t) -> ecs_table_records_t ---

	/** Get the component record from a table record.
	*
	* @param tr The table record.
	* @return The component record.
	*/
	flecs_table_record_get_component :: proc(tr: ^ecs_table_record_t) -> ^ecs_component_record_t ---

	/** Get the table ID.
	* This operation returns a unique numerical identifier for a table.
	*
	* @param table The table.
	* @return The unique identifier for the table.
	*/
	flecs_table_id :: proc(table: ^ecs_table_t) -> u64 ---

	/** Find a table by adding an ID to the current table.
	* Same as ecs_table_add_id(), but with an additional diff parameter that contains
	* information about the traversed edge.
	*
	* @param world The world.
	* @param table The table.
	* @param id_ptr Pointer to the component ID to add.
	* @param diff Information about the traversed edge (out parameter).
	* @return The table that was traversed to.
	*/
	flecs_table_traverse_add :: proc(world: ^ecs_world_t, table: ^ecs_table_t, id_ptr: ^ecs_id_t, diff: ^ecs_table_diff_t) -> ^ecs_table_t ---
}

/** Utility to hold a value of a dynamic type. */
ecs_value_t :: struct {
	type: ecs_entity_t, /**< Type of value. */
	ptr:  rawptr,       /**< Pointer to value. */
}

/** Used with ecs_entity_init().
*
* @ingroup entities
*/
ecs_entity_desc_t :: struct {
	_canary:    i32,          /**< Used for validity testing. Must be 0. */
	id:         ecs_entity_t, /**< Set to modify existing entity (optional). */
	parent:     ecs_entity_t, /**< Parent entity. */
	name:       cstring,      /**< Name of the entity. If no entity is provided, an
                           * entity with this name will be looked up first. When
                           * an entity is provided, the name will be verified
                           * with the existing entity. */
	sep:        cstring,      /**< Optional custom separator for hierarchical names.
                           * Leave to NULL for the default ('.') separator. Set to
                           * an empty string to prevent tokenization of the name. */
	root_sep:   cstring,      /**< Optional, used for identifiers relative to the root. */
	symbol:     cstring,      /**< Optional entity symbol. A symbol is an unscoped
                           * identifier that can be used to look up an entity. The
                           * primary use case for this is to associate the entity
                           * with a language identifier, such as a type or
                           * function name, where these identifiers differ from
                           * the name they are registered with in Flecs. For
                           * example, C type "EcsPosition" might be registered
                           * as "flecs.components.transform.Position", with the
                           * symbol set to "EcsPosition". */
	use_low_id: bool,         /**< When set to true, a low id (typically reserved for
                           * components) will be used to create the entity, if
                           * no ID is specified. */

	/** 0-terminated array of IDs to add to the entity. */
	add: ^ecs_id_t,

	/** 0-terminated array of values to set on the entity. */
	set: ^ecs_value_t,

	/** String expression with components to add. */
	add_expr: cstring,
}

/** Used with ecs_bulk_init().
*
* @ingroup entities
*/
ecs_bulk_desc_t :: struct {
	_canary:  i32,           /**< Used for validity testing. Must be 0. */
	entities: ^ecs_entity_t, /**< Entities to bulk insert. Entity IDs provided by
                             * the application must be empty (cannot
                             * have components). If no entity IDs are provided, the
                             * operation will create 'count' new entities. */
	count:    i32,           /**< Number of entities to create/populate. */
	ids:      [32]ecs_id_t,  /**< IDs to create the entities with. */
	data:     ^rawptr,       /**< Array with component data to insert. Each element in
                        * the array must correspond with an element in the ids
                        * array. If an element in the ids array is a tag, the
                        * data array must contain a NULL. An element may be
                        * set to NULL for a component, in which case the
                        * component will not be set by the operation. */
	table:    ^ecs_table_t,  /**< Table to insert the entities into. Should not be set
                         * at the same time as ids. When 'table' is set at the
                         * same time as 'data', the elements in the data array
                         * must correspond with the ids in the table's type. */
}

/** Used with ecs_component_init().
*
* @ingroup components
*/
ecs_component_desc_t :: struct {
	_canary: i32, /**< Used for validity testing. Must be 0. */

	/** Existing entity to associate with a component (optional). */
	entity: ecs_entity_t,

	/** Parameters for type (size, hooks, ...). */
	type: ecs_type_info_t,
}

/** Iterator.
* Used for iterating queries. The ecs_iter_t type contains all the information
* that is provided by a query, and contains all the state required for the
* iterator code.
*
* Functions that create iterators accept as first argument the world, and as
* second argument the object they iterate. For example:
*
* @code
* ecs_iter_t it = ecs_query_iter(world, q);
* @endcode
*
* When this code is called from a system, it is important to use the world
* provided by its iterator object to ensure thread safety. For example:
*
* @code
* void Collide(ecs_iter_t *it) {
*   ecs_iter_t qit = ecs_query_iter(it->world, Colliders);
* }
* @endcode
*
* An iterator contains resources that need to be released. By default, this
* is handled by the last call to next() that returns false. When iteration is
* ended before iteration has completed, an application has to manually call
* ecs_iter_fini() to release the iterator resources:
*
* @code
* ecs_iter_t it = ecs_query_iter(world, q);
* while (ecs_query_next(&it)) {
*   if (cond) {
*     ecs_iter_fini(&it);
*     break;
*   }
* }
* @endcode
*
* @ingroup queries
*/
ecs_iter_t :: struct {
	/* World */
	world:      ^ecs_world_t, /**< The world. Can point to a stage when in deferred or readonly mode. */
	real_world: ^ecs_world_t, /**< Actual world. Never points to a stage. */

	/* Matched data */
	offset:           i32,                  /**< Offset relative to the current table. */
	count:            i32,                  /**< Number of entities to iterate. */
	entities:         ^ecs_entity_t,        /**< Entity identifiers. */
	ptrs:             ^rawptr,              /**< Component pointers. If not set or if it is NULL for a field, use it->trs. */
	trs:              ^^ecs_table_record_t, /**< Info on where to find the field in the table. */
	columns:          ^i16,
	sizes:            ^ecs_size_t,          /**< Component sizes. */
	table:            ^ecs_table_t,         /**< Current table. */
	other_table:      ^ecs_table_t,         /**< Previous or next table when adding or removing. */
	ids:              ^ecs_id_t,            /**< (Component) IDs. */
	sources:          ^ecs_entity_t,        /**< Entity on which the ID was matched (0 if same as entities). */
	constrained_vars: ecs_flags64_t,        /**< Bitset that marks constrained variables. */
	set_fields:       ecs_flags32_t,        /**< Fields that are set. */
	ref_fields:       ecs_flags32_t,        /**< Bitset with fields that aren't component arrays. */
	row_fields:       ecs_flags32_t,        /**< Fields that must be obtained with field_at. */
	up_fields:        ecs_flags32_t,        /**< Bitset with fields matched through up traversal. */

	/* Input information */
	system:    ecs_entity_t, /**< The system (if applicable). */
	event:     ecs_entity_t, /**< The event (if applicable). */
	event_id:  ecs_id_t,     /**< The (component) ID for the event. */
	event_cur: i32,          /**< Unique event ID. Used to dedup observer calls. */

	/* Query information */
	field_count: i8,           /**< Number of fields in the iterator. */
	term_index:  i8,           /**< Index of the term that emitted an event.
                                   * This field will be set to the 'index' field
                                   * of an observer term. */
	query:       ^ecs_query_t, /**< Query being evaluated. */

	/* Context */
	param:        rawptr, /**< Param passed to ecs_run(). */
	ctx:          rawptr, /**< System context. */
	binding_ctx:  rawptr, /**< System binding context. */
	callback_ctx: rawptr, /**< Callback language binding context. */
	run_ctx:      rawptr, /**< Run language binding context. */

	/* Time */
	delta_time:        f32, /**< Time elapsed since last frame. */
	delta_system_time: f32, /**< Time elapsed since last system invocation. */

	/* Iterator counters */
	frame_offset: i32, /**< Offset relative to the start of iteration. */

	/* Misc */
	flags:          ecs_flags32_t,      /**< Iterator flags. */
	interrupted_by: ecs_entity_t,       /**< When set, system execution is interrupted. */
	priv_:          ecs_iter_private_t, /**< Private data. */

	/* Chained iterators */
	next:     ecs_iter_next_action_t, /**< Function to progress iterator. */
	callback: ecs_iter_action_t,      /**< Callback of system or observer. */
	fini:     ecs_iter_fini_action_t, /**< Function to clean up iterator resources. */
	chain_it: ^ecs_iter_t,            /**< Optional, allows for creating iterator chains. */
}

/** Query must match prefabs.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryMatchPrefab           :: (1<<1)

/** Query must match disabled entities.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryMatchDisabled         :: (1<<2)

/** Query must match empty tables.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryMatchEmptyTables      :: (1<<3)

/** Query may have unresolved entity identifiers.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryAllowUnresolvedByName :: (1<<6)

/** Query only returns whole tables (ignores toggle or member fields).
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
* \ingroup queries
*/
EcsQueryTableOnly             :: (1<<7)

/** Enable change detection for a query.
* Can be combined with other query flags on the ecs_query_desc_t::flags field.
*
* Adding this flag makes it possible to use ecs_query_changed() and
* ecs_iter_changed() with the query. Change detection requires the query to be
* cached. If cache_kind is left to the default value, this flag will cause it
* to default to EcsQueryCacheAuto.
*
* \ingroup queries
*/
EcsQueryDetectChanges         :: (1<<8)

/** Enable ordering for query groups.
* When this flag is set, groups will be iterated in ascending order, with lower
* group ids first and higher group ids afterwards.
*
* This flag is enabled automatically when a query contains cascade terms.
*
* \ingroup queries
*/
EcsQueryGroupByOrdered        :: (1<<9)

/** Enable descending ordering for query groups.
* When this flag is set in combination with EcsQueryGroupByOrdered, groups will
* be iterated in descending order, with higher group ids first and lower group
* ids afterwards.
*
* This flag is enabled automatically when a query contains cascade|desc terms.
*
* \ingroup queries
*/
EcsQueryGroupByDesc           :: (1<<10)

/** Used with ecs_query_init().
*
* \ingroup queries
*/
ecs_query_desc_t :: struct {
	/** Used for validity testing. Must be 0. */
	_canary: i32,

	/** Query terms. */
	terms: [32]ecs_term_t,

	/** Query DSL expression (optional). */
	expr: cstring,

	/** Caching policy of the query. */
	cache_kind: ecs_query_cache_kind_t,

	/** Flags for enabling query features. */
	flags: ecs_flags32_t,

	/** Callback used for ordering query results. If order_by is 0, the
	* pointer provided to the callback will be NULL. If the callback is not
	* set, results will not be ordered. */
	order_by_callback: ecs_order_by_action_t,

	/** Callback used for ordering query results. Same as order_by_callback,
	* but more efficient. */
	order_by_table_callback: ecs_sort_table_action_t,

	/** Component to sort on, used together with order_by_callback or
	* order_by_table_callback. */
	order_by: ecs_entity_t,

	/** Component ID to be used for grouping. Used together with the
	* group_by_callback. */
	group_by: ecs_id_t,

	/** Callback used for grouping results. If the callback is not set, results
	* will not be grouped. When set, this callback will be used to calculate a
	* "rank" for each entity (table) based on its components. This rank is then
	* used to sort entities (tables), so that entities (tables) of the same
	* rank are "grouped" together when iterated. */
	group_by_callback: ecs_group_by_action_t,

	/** Callback that is invoked when a new group is created. The return value of
	* the callback is stored as context for a group. */
	on_group_create: ecs_group_create_action_t,

	/** Callback that is invoked when an existing group is deleted. The return
	* value of the on_group_create callback is passed as context parameter. */
	on_group_delete: ecs_group_delete_action_t,

	/** Context to pass to group_by. */
	group_by_ctx: rawptr,

	/** Function to free group_by_ctx. */
	group_by_ctx_free: ecs_ctx_free_t,

	/** User context to pass to callback. */
	ctx: rawptr,

	/** Context to be used for language bindings. */
	binding_ctx: rawptr,

	/** Callback to free ctx. */
	ctx_free: ecs_ctx_free_t,

	/** Callback to free binding_ctx. */
	binding_ctx_free: ecs_ctx_free_t,

	/** Entity associated with query (optional). */
	entity: ecs_entity_t,
}

/** Used with ecs_observer_init().
*
* @ingroup observers
*/
ecs_observer_desc_t :: struct {
	/** Used for validity testing. Must be 0. */
	_canary: i32,

	/** Existing entity to associate with an observer (optional). */
	entity: ecs_entity_t,

	/** Query for observer. */
	query: ecs_query_desc_t,

	/** Events to observe (OnAdd, OnRemove, OnSet). */
	events: [8]ecs_entity_t,

	/** When an observer is created, generate events from existing data. For example,
	* #EcsOnAdd `Position` would match all existing instances of `Position`. */
	yield_existing: bool,

	/** Global observers are tied to the lifespan of the world. Creating a
	* global observer does not create an entity, and therefore
	* ecs_observer_init() will not return an entity handle. */
	global_observer: bool,

	/** Callback to invoke on an event, invoked when the observer matches. */
	callback: ecs_iter_action_t,

	/** Callback invoked on an event. When left to NULL, the default runner
	* is used, which matches the event with the observer's query, and calls
	* 'callback' when it matches.
	* A reason to override the run function is to improve performance, if there
	* are more efficient ways to test whether an event matches the observer than
	* the general-purpose query matcher. */
	run: ecs_run_action_t,

	/** User context to pass to callback. */
	ctx: rawptr,

	/** Callback to free ctx. */
	ctx_free: ecs_ctx_free_t,

	/** Context associated with callback (for language bindings). */
	callback_ctx: rawptr,

	/** Callback to free callback ctx. */
	callback_ctx_free: ecs_ctx_free_t,

	/** Context associated with run (for language bindings). */
	run_ctx: rawptr,

	/** Callback to free run ctx. */
	run_ctx_free: ecs_ctx_free_t,

	/** Used for internal purposes. Do not set. */
	last_event_id: ^i32,
	term_index_:   i8,            /**< Used for internal purposes. Do not set. */
	flags_:        ecs_flags32_t, /**< Used for internal purposes. Do not set. */
}

/** Used with ecs_emit().
*
* @ingroup observers
*/
ecs_event_desc_t :: struct {
	/** The event ID. Only observers for the specified event will be notified. */
	event: ecs_entity_t,

	/** Component IDs. Only observers with a matching component ID will be
	* notified. Observers are guaranteed to get notified once, even if they
	* match more than one ID. */
	ids: ^ecs_type_t,

	/** The table for which to notify. */
	table: ^ecs_table_t,

	/** Optional second table to notify. This can be used to communicate the
	* previous or next table, in case an entity is moved between tables. */
	other_table: ^ecs_table_t,

	/** Limit notified entities to ones starting from offset (row) in table. */
	offset: i32,

	/** Limit number of notified entities to count. offset+count must be less
	* than the total number of entities in the table. If left to 0, it will be
	* automatically determined by doing `ecs_table_count(table) - offset`. */
	count: i32,

	/** Single-entity alternative to setting table / offset / count. */
	entity: ecs_entity_t,

	/** Optional context.
	* The type of the param must be the event, where the event is a component.
	* When an event is enqueued, the value of param is copied to a temporary
	* storage of the event type. */
	param: rawptr,

	/** Same as param, but with the guarantee that the value won't be modified.
	* When an event with a const parameter is enqueued, the value of the param
	* is copied to a temporary storage of the event type. */
	const_param: rawptr,

	/** Observable (usually the world). */
	observable: ^ecs_poly_t,

	/** Event flags. */
	flags: ecs_flags32_t,
}

/** Type with information about the current Flecs build. */
ecs_build_info_t :: struct {
	compiler:      cstring,  /**< Compiler used to compile Flecs. */
	addons:        ^cstring, /**< Addons included in the build. */
	flags:         ^cstring, /**< Compile-time settings. */
	version:       cstring,  /**< Stringified version. */
	version_major: i16,      /**< Major Flecs version. */
	version_minor: i16,      /**< Minor Flecs version. */
	version_patch: i16,      /**< Patch Flecs version. */
	debug:         bool,     /**< Is this a debug build? */
	sanitize:      bool,     /**< Is this a sanitize build? */
	perf_trace:    bool,     /**< Is this a perf tracing build? */
}

/** Type that contains information about the world. */
ecs_world_info_t :: struct {
	last_component_id:          ecs_entity_t, /**< Last issued component entity ID. */
	delta_time_raw:             f32,          /**< Raw delta time (no time scaling). */
	delta_time:                 f32,          /**< Time passed to or computed by ecs_progress(). */
	time_scale:                 f32,          /**< Time scale applied to delta_time. */
	target_fps:                 f32,          /**< Target FPS. */
	frame_time_total:           f32,          /**< Total time spent processing a frame. */
	system_time_total:          f32,          /**< Total time spent in systems. */
	emit_time_total:            f32,          /**< Total time spent notifying observers. */
	merge_time_total:           f32,          /**< Total time spent in merges. */
	rematch_time_total:         f32,          /**< Time spent on query rematching. */
	world_time_total:           f64,          /**< Time elapsed in simulation. */
	world_time_total_raw:       f64,          /**< Time elapsed in simulation (no scaling). */
	frame_count_total:          i64,          /**< Total number of frames. */
	merge_count_total:          i64,          /**< Total number of merges. */
	eval_comp_monitors_total:   i64,          /**< Total number of monitor evaluations. */
	rematch_count_total:        i64,          /**< Total number of rematches. */
	id_create_total:            i64,          /**< Total number of times a new ID was created. */
	id_delete_total:            i64,          /**< Total number of times an ID was deleted. */
	table_create_total:         i64,          /**< Total number of times a table was created. */
	table_delete_total:         i64,          /**< Total number of times a table was deleted. */
	pipeline_build_count_total: i64,          /**< Total number of pipeline builds. */
	systems_ran_total:          i64,          /**< Total number of systems run. */
	observers_ran_total:        i64,          /**< Total number of times an observer was invoked. */
	queries_ran_total:          i64,          /**< Total number of times a query was evaluated. */
	tag_id_count:               i32,          /**< Number of tag (no data) IDs in the world. */
	component_id_count:         i32,          /**< Number of component (data) IDs in the world. */
	pair_id_count:              i32,          /**< Number of pair IDs in the world. */
	table_count:                i32,          /**< Number of tables. */
	creation_time:              u32,          /**< Time when world was created. */

	cmd: struct {
		add_count:             i64, /**< Add commands processed. */
		remove_count:          i64, /**< Remove commands processed. */
		delete_count:          i64, /**< Delete commands processed. */
		clear_count:           i64, /**< Clear commands processed. */
		set_count:             i64, /**< Set commands processed. */
		ensure_count:          i64, /**< Ensure or emplace commands processed. */
		modified_count:        i64, /**< Modified commands processed. */
		discard_count:         i64, /**< Commands discarded, happens when the entity is no longer alive when running the command. */
		event_count:           i64, /**< Enqueued custom events. */
		other_count:           i64, /**< Other commands processed. */
		batched_entity_count:  i64, /**< Entities for which commands were batched. */
		batched_command_count: i64, /**< Commands batched. */
	}, /**< Command statistics. */

	name_prefix: cstring, /**< Value set by ecs_set_name_prefix(). Used
                                       * to remove library prefixes of symbol
                                       * names (such as `Ecs`, `ecs_`) when
                                       * registering them as names. */
}

/** Type that contains information about a query group. */
ecs_query_group_info_t :: struct {
	id:          u64,    /**< Group ID. */
	match_count: i32,    /**< How often tables have been matched or unmatched. */
	table_count: i32,    /**< Number of tables in group. */
	ctx:         rawptr, /**< Group context, returned by on_group_create. */
}

/** Type that stores an entity id range.
* Returned by ecs_entity_range_new(), used with ecs_entity_range_set().
*/
ecs_entity_range_t :: struct {
	min:      u32,       /**< First id in range (inclusive). */
	max:      u32,       /**< Last id in range (inclusive, 0 = unlimited). */
	cur:      u32,       /**< Last issued id in range. */
	recycled: ecs_vec_t, /**< Recycled entity ids (vec<entity_t>). */
}

/** A (string) identifier. Used as a pair with #EcsName and #EcsSymbol tags. */
EcsIdentifier :: struct {
	value:      cstring,        /**< Identifier string. */
	length:     ecs_size_t,     /**< Length of identifier. */
	hash:       u64,            /**< Hash of current value. */
	index_hash: u64,            /**< Hash of existing record in current index. */
	index:      ^ecs_hashmap_t, /**< Current index. */
}

/** Component information. */
EcsComponent :: struct {
	size:      ecs_size_t, /**< Component size. */
	alignment: ecs_size_t, /**< Component alignment. */
}

/** Component for storing a poly object. */
EcsPoly :: struct {
	poly: ^ecs_poly_t, /**< Pointer to poly object. */
}

/** When added to an entity, this informs serialization formats which component
* to use when a value is assigned to an entity without specifying the
* component. This is intended as a hint; serialization formats are not required
* to use it. Adding this component does not change the behavior of core ECS
* operations. */
EcsDefaultChildComponent :: struct {
	component: ecs_id_t, /**< Default component ID. */
}

/** Non-fragmenting ChildOf relationship. */
EcsParent :: struct {
	value: ecs_entity_t, /**< Parent entity. */
}

/** Component with data to instantiate a non-fragmenting tree. */
ecs_tree_spawner_child_t :: struct {
	child_name:   cstring,      /**< Name of the prefab child. */
	table:        ^ecs_table_t, /**< Table in which the child will be stored. */
	child:        u32,          /**< Prefab child entity (without generation). */
	parent_index: i32,          /**< Index into the children vector. */
}

/** Tree spawner data for a single hierarchy depth. */
ecs_tree_spawner_t :: struct {
	children: ecs_vec_t, /**< vector<ecs_tree_spawner_child_t>. */
}

/** Tree instantiation cache component.
* Tree instantiation cache, indexed by depth. Tables will have a
* (ParentDepth, depth) pair indicating the hierarchy depth. This means that
* for different depths, the tables the children are created in will also be
* different. Caching tables for different depths therefore speeds up
* instantiating trees even when the top-level entity is not at the root.
*/
EcsTreeSpawner :: struct {
	data: [6]ecs_tree_spawner_t, /**< Cache data indexed by depth. */
}

/** The first user-defined component starts from this ID. IDs up to this number
* are reserved for built-in components. */
EcsFirstUserComponentId :: (8)

/** The first user-defined entity starts from this ID. IDs up to this number
* are reserved for built-in entities. */
EcsFirstUserEntityId :: (FLECS_HI_COMPONENT_ID+128)

@(default_calling_convention="c")
foreign lib {
	/** Create a new world.
	* This operation automatically imports modules from addons Flecs has been built
	* with, except when the module specifies otherwise.
	*
	* @return A new world.
	*/
	ecs_init :: proc() -> ^ecs_world_t ---

	/** Create a new world with just the core module.
	* Same as ecs_init(), but doesn't import modules from addons. This operation is
	* faster than ecs_init() and results in less memory utilization.
	*
	* @return A new tiny world.
	*/
	ecs_mini :: proc() -> ^ecs_world_t ---

	/** Create a new world with arguments.
	* Same as ecs_init(), but allows passing in command-line arguments. Command-line
	* arguments are used to:
	* - automatically derive the name of the application from argv[0]
	*
	* @param argc The number of arguments.
	* @param argv The argument array.
	* @return A new world.
	*/
	ecs_init_w_args :: proc(argc: i32, argv: [^]cstring) -> ^ecs_world_t ---

	/** Delete a world.
	* This operation deletes the world, and everything it contains.
	*
	* @param world The world to delete.
	* @return Zero if successful, non-zero if failed.
	*/
	ecs_fini :: proc(world: ^ecs_world_t) -> i32 ---

	/** Return whether the world is being deleted.
	* This operation can be used in callbacks like type hooks or observers to
	* detect if they are invoked while the world is being deleted.
	*
	* @param world The world.
	* @return True if being deleted, false if not.
	*/
	ecs_is_fini :: proc(world: ^ecs_world_t) -> bool ---

	/** Register an action to be executed when the world is destroyed.
	* Fini actions are typically used when a module needs to clean up before the
	* world shuts down.
	*
	* @param world The world.
	* @param action The function to execute.
	* @param ctx Userdata to pass to the function.
	*/
	ecs_atfini :: proc(world: ^ecs_world_t, action: ecs_fini_action_t, ctx: rawptr) ---
}

/** Type returned by ecs_get_entities(). */
ecs_entities_t :: struct {
	ids:         ^ecs_entity_t, /**< Array with all entity IDs in the world. */
	count:       i32,           /**< Total number of entity IDs. */
	alive_count: i32,           /**< Number of alive entity IDs. */
}

@(default_calling_convention="c")
foreign lib {
	/** Return entity identifiers in the world.
	* This operation returns an array with all entity IDs that exist in the world.
	* Note that the returned array will change and may get invalidated as a result
	* of entity creation and deletion.
	*
	* To iterate all alive entity IDs, do:
	* @code
	* ecs_entities_t entities = ecs_get_entities(world);
	* for (int i = 0; i < entities.alive_count; i ++) {
	*   ecs_entity_t id = entities.ids[i];
	* }
	* @endcode
	*
	* To iterate not-alive IDs, do:
	* @code
	* for (int i = entities.alive_count + 1; i < entities.count; i ++) {
	*   ecs_entity_t id = entities.ids[i];
	* }
	* @endcode
	*
	* The returned array does not need to be freed. Mutating the returned array
	* will result in undefined behavior (and likely crashes).
	*
	* @param world The world.
	* @return Struct with entity ID array.
	*/
	ecs_get_entities :: proc(world: ^ecs_world_t) -> ecs_entities_t ---

	/** Get flags set on the world.
	* This operation returns the internal flags (see api_flags.h) that are
	* set on the world.
	*
	* @param world The world.
	* @return Flags set on the world.
	*/
	ecs_world_get_flags :: proc(world: ^ecs_world_t) -> ecs_flags32_t ---

	/** Begin frame.
	* When an application does not use ecs_progress() to control the main loop, it
	* can still use Flecs features such as FPS limiting and time measurements. This
	* operation needs to be invoked whenever a new frame is about to get processed.
	*
	* Calls to ecs_frame_begin() must always be followed by ecs_frame_end().
	*
	* The function accepts a delta_time parameter, which will get passed to
	* systems. This value is also used to compute the amount of time the function
	* needs to sleep to ensure it does not exceed the target_fps, when it is set.
	* When 0 is provided for delta_time, the time will be measured.
	*
	* This function should only be run from the main thread.
	*
	* @param world The world.
	* @param delta_time Time elapsed since the last frame.
	* @return The provided delta_time, or measured time if 0 was provided.
	*/
	ecs_frame_begin :: proc(world: ^ecs_world_t, delta_time: f32) -> f32 ---

	/** End frame.
	* This operation must be called at the end of the frame, and always after
	* ecs_frame_begin().
	*
	* @param world The world.
	*/
	ecs_frame_end :: proc(world: ^ecs_world_t) ---

	/** Register an action to be executed once after the frame.
	* Post frame actions are typically used for calling operations that cannot be
	* invoked during iteration, such as changing the number of threads.
	*
	* @param world The world.
	* @param action The function to execute.
	* @param ctx Userdata to pass to the function.
	*/
	ecs_run_post_frame :: proc(world: ^ecs_world_t, action: ecs_fini_action_t, ctx: rawptr) ---

	/** Signal exit.
	* This operation signals that the application should quit. It will cause
	* ecs_progress() to return false.
	*
	* @param world The world to quit.
	*/
	ecs_quit :: proc(world: ^ecs_world_t) ---

	/** Return whether a quit has been requested.
	*
	* @param world The world.
	* @return Whether a quit has been requested.
	* @see ecs_quit()
	*/
	ecs_should_quit :: proc(world: ^ecs_world_t) -> bool ---

	/** Measure frame time.
	* Frame time measurements measure the total time passed in a single frame, and
	* how much of that time was spent on systems and on merging.
	*
	* Frame time measurements add a small constant-time overhead to an application.
	* When an application sets a target FPS, frame time measurements are enabled by
	* default.
	*
	* @param world The world.
	* @param enable Whether to enable or disable frame time measuring.
	*/
	ecs_measure_frame_time :: proc(world: ^ecs_world_t, enable: bool) ---

	/** Measure system time.
	* System time measurements measure the time spent in each system.
	*
	* System time measurements add overhead to every system invocation and
	* therefore have a small but measurable impact on application performance.
	* System time measurements must be enabled before obtaining system statistics.
	*
	* @param world The world.
	* @param enable Whether to enable or disable system time measuring.
	*/
	ecs_measure_system_time :: proc(world: ^ecs_world_t, enable: bool) ---

	/** Set target frames per second (FPS) for an application.
	* Setting the target FPS ensures that ecs_progress() is not invoked faster than
	* the specified FPS. When enabled, ecs_progress() tracks the time passed since
	* the last invocation, and sleeps the remaining time of the frame (if any).
	*
	* This feature ensures systems are run at a consistent interval, as well as
	* conserving CPU time by not running systems more often than required.
	*
	* Note that ecs_progress() only sleeps if there is time left in the frame. Both
	* time spent in Flecs and time spent outside of Flecs are taken into
	* account.
	*
	* @param world The world.
	* @param fps The target FPS.
	*/
	ecs_set_target_fps :: proc(world: ^ecs_world_t, fps: f32) ---

	/** Set the default query flags.
	* Set a default value for the ecs_query_desc_t::flags field. Default flags
	* are applied in addition to the flags provided in the descriptor. For a
	* list of available flags, see include/flecs/private/api_flags.h. Typical flags
	* to use are:
	*
	*  - `EcsQueryMatchEmptyTables`
	*  - `EcsQueryMatchDisabled`
	*  - `EcsQueryMatchPrefab`
	*
	* @param world The world.
	* @param flags The query flags.
	*/
	ecs_set_default_query_flags :: proc(world: ^ecs_world_t, flags: ecs_flags32_t) ---

	/** Begin readonly mode.
	* This operation puts the world in readonly mode, which disallows mutations on
	* the world. Readonly mode exists so that internal mechanisms can implement
	* optimizations that assume certain aspects of the world do not change, while also
	* providing a mechanism for applications to prevent accidental mutations in,
	* for example, multithreaded applications.
	*
	* Readonly mode is a stronger version of deferred mode. In deferred mode,
	* ECS operations such as add, remove, set, delete, etc. are added to a command
	* queue to be executed later. In readonly mode, operations that could break
	* scheduler logic (such as creating systems, queries) are also disallowed.
	*
	* Readonly mode itself has a single-threaded and a multithreaded mode. In
	* single-threaded mode, certain mutations on the world are still allowed, for
	* example:
	* - Entity liveliness operations (such as ecs_new(), ecs_make_alive()), so that systems are
	*   able to create new entities.
	* - Implicit component registration, so that it works from systems.
	* - Mutations to supporting data structures for the evaluation of uncached
	*   queries, so that these can be created on the fly.
	*
	* These mutations are safe in single-threaded applications, but for
	* multithreaded applications the world needs to be entirely immutable. For this
	* purpose, multithreaded readonly mode exists, which disallows all mutations on
	* the world. This means that in multithreaded applications, entity liveliness
	* operations, implicit component registration, and on-the-fly query creation
	* are not guaranteed to work.
	*
	* While in readonly mode, applications can still enqueue ECS operations on a
	* stage. Stages are managed automatically when using the pipeline addon and
	* ecs_progress(), but they can also be configured manually as shown here:
	*
	* @code
	* // Number of stages typically corresponds with number of threads
	* ecs_set_stage_count(world, 2);
	* ecs_world_t *stage = ecs_get_stage(world, 1);
	*
	* ecs_readonly_begin(world, false);
	* ecs_add(world, e, Tag); // readonly assert
	* ecs_add(stage, e, Tag); // OK
	* @endcode
	*
	* When an attempt is made to perform an operation on a world in readonly mode,
	* the code will throw an assert saying that the world is in readonly mode.
	*
	* A call to ecs_readonly_begin() must be followed up with ecs_readonly_end().
	* When ecs_readonly_end() is called, all enqueued commands from configured
	* stages are merged back into the world. Calls to ecs_readonly_begin() and
	* ecs_readonly_end() should always happen from a context where the code has
	* exclusive access to the world. The functions themselves are not thread-safe.
	*
	* In a typical application, a (non-exhaustive) call stack that uses
	* ecs_readonly_begin() and ecs_readonly_end() will look like this:
	*
	* @code
	* ecs_progress()
	*   ecs_readonly_begin()
	*     ecs_defer_begin()
	*
	*       // user code
	*
	*   ecs_readonly_end()
	*     ecs_defer_end()
	* @endcode
	*
	* @param world The world.
	* @param multi_threaded Whether to enable multithreaded readonly mode.
	* @return Whether world is in readonly mode.
	*/
	ecs_readonly_begin :: proc(world: ^ecs_world_t, multi_threaded: bool) -> bool ---

	/** End readonly mode.
	* This operation ends readonly mode, and must be called after
	* ecs_readonly_begin(). Operations that were deferred while the world was in
	* readonly mode will be flushed.
	*
	* @param world The world.
	*/
	ecs_readonly_end :: proc(world: ^ecs_world_t) ---

	/** Merge a stage.
	* This will merge all commands enqueued for a stage.
	*
	* @param stage The stage.
	*/
	ecs_merge :: proc(stage: ^ecs_world_t) ---

	/** Defer operations until the end of the frame.
	* When this operation is invoked while iterating, operations between the
	* ecs_defer_begin() and ecs_defer_end() operations are executed at the end
	* of the frame.
	*
	* This operation is thread-safe.
	*
	* @param world The world.
	* @return true if world changed from non-deferred mode to deferred mode.
	*
	* @see ecs_defer_end()
	* @see ecs_is_deferred()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	* @see ecs_is_defer_suspended()
	*/
	ecs_defer_begin :: proc(world: ^ecs_world_t) -> bool ---

	/** End a block of operations to defer.
	* See ecs_defer_begin().
	*
	* This operation is thread-safe.
	*
	* @param world The world.
	* @return true if world changed from deferred mode to non-deferred mode.
	*
	* @see ecs_defer_begin()
	* @see ecs_is_deferred()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	*/
	ecs_defer_end :: proc(world: ^ecs_world_t) -> bool ---

	/** Suspend deferring but do not flush queue.
	* This operation can be used to do an undeferred operation while not flushing
	* the operations in the queue.
	*
	* An application should invoke ecs_defer_resume() before ecs_defer_end() is called.
	* The operation may only be called when deferring is enabled.
	*
	* @param world The world.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_is_deferred()
	* @see ecs_defer_resume()
	*/
	ecs_defer_suspend :: proc(world: ^ecs_world_t) ---

	/** Resume deferring.
	* See ecs_defer_suspend().
	*
	* @param world The world.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_is_deferred()
	* @see ecs_defer_suspend()
	*/
	ecs_defer_resume :: proc(world: ^ecs_world_t) ---

	/** Test if deferring is enabled for the current stage.
	*
	* @param world The world.
	* @return True if deferred, false if not.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	* @see ecs_is_defer_suspended()
	*/
	ecs_is_deferred :: proc(world: ^ecs_world_t) -> bool ---

	/** Test if deferring is suspended for the current stage.
	*
	* @param world The world.
	* @return True if suspended, false if not.
	*
	* @see ecs_defer_begin()
	* @see ecs_defer_end()
	* @see ecs_is_deferred()
	* @see ecs_defer_resume()
	* @see ecs_defer_suspend()
	*/
	ecs_is_defer_suspended :: proc(world: ^ecs_world_t) -> bool ---

	/** Configure the world to have N stages.
	* This initializes N stages, which allows applications to defer operations to
	* multiple isolated defer queues. This is typically used for applications with
	* multiple threads, where each thread gets its own queue, and commands are
	* merged when threads are synchronized.
	*
	* Note that the ecs_set_threads() function already creates the appropriate
	* number of stages. The ecs_set_stage_count() operation is useful for applications
	* that want to manage their own stages and/or threads.
	*
	* @param world The world.
	* @param stages The number of stages.
	*/
	ecs_set_stage_count :: proc(world: ^ecs_world_t, stages: i32) ---

	/** Get the number of configured stages.
	* Return the number of stages set by ecs_set_stage_count().
	*
	* @param world The world.
	* @return The number of stages used for threading.
	*/
	ecs_get_stage_count :: proc(world: ^ecs_world_t) -> i32 ---

	/** Get stage-specific world pointer.
	* Flecs threads can safely invoke the API as long as they have a private
	* context to write to, also referred to as the stage. This function returns a
	* pointer to a stage, disguised as a world pointer.
	*
	* Note that this function does not create a new world. It simply wraps the
	* existing world in a thread-specific context, which the API knows how to
	* unwrap. The reason the stage is returned as an ecs_world_t is so that it
	* can be passed transparently to the existing API functions, instead of having to
	* create a dedicated API for threading.
	*
	* @param world The world.
	* @param stage_id The index of the stage to retrieve.
	* @return A thread-specific pointer to the world.
	*/
	ecs_get_stage :: proc(world: ^ecs_world_t, stage_id: i32) -> ^ecs_world_t ---

	/** Test whether the current world is readonly.
	* This function allows the code to test whether the currently used world
	* is readonly or whether it allows for writing.
	*
	* @param world A pointer to a stage or the world.
	* @return True if the world or stage is readonly.
	*/
	ecs_stage_is_readonly :: proc(world: ^ecs_world_t) -> bool ---

	/** Create an unmanaged stage.
	* Create a stage whose lifecycle is not managed by the world. Must be freed
	* with ecs_stage_free().
	*
	* @param world The world.
	* @return The stage.
	*/
	ecs_stage_new :: proc(world: ^ecs_world_t) -> ^ecs_world_t ---

	/** Free an unmanaged stage.
	*
	* @param stage The stage to free.
	*/
	ecs_stage_free :: proc(stage: ^ecs_world_t) ---

	/** Get the stage ID.
	* The stage ID can be used by an application to learn about which stage it is
	* using, which typically corresponds with the worker thread ID.
	*
	* @param world The world.
	* @return The stage ID.
	*/
	ecs_stage_get_id :: proc(world: ^ecs_world_t) -> i32 ---

	/** Set a world context.
	* This operation allows an application to register custom data with a world
	* that can be accessed anywhere where the application has the world.
	*
	* @param world The world.
	* @param ctx A pointer to a user-defined structure.
	* @param ctx_free A function that is invoked with ctx when the world is freed.
	*/
	ecs_set_ctx :: proc(world: ^ecs_world_t, ctx: rawptr, ctx_free: ecs_ctx_free_t) ---

	/** Set a world binding context.
	* Same as ecs_set_ctx(), but for binding context. A binding context is intended
	* specifically for language bindings to store binding-specific data.
	*
	* @param world The world.
	* @param ctx A pointer to a user-defined structure.
	* @param ctx_free A function that is invoked with ctx when the world is freed.
	*/
	ecs_set_binding_ctx :: proc(world: ^ecs_world_t, ctx: rawptr, ctx_free: ecs_ctx_free_t) ---

	/** Get the world context.
	* This operation retrieves a previously set world context.
	*
	* @param world The world.
	* @return The context set with ecs_set_ctx(). If no context was set, the
	*         function returns NULL.
	*/
	ecs_get_ctx :: proc(world: ^ecs_world_t) -> rawptr ---

	/** Get the world binding context.
	* This operation retrieves a previously set world binding context.
	*
	* @param world The world.
	* @return The context set with ecs_set_binding_ctx(). If no context was set, the
	*         function returns NULL.
	*/
	ecs_get_binding_ctx :: proc(world: ^ecs_world_t) -> rawptr ---

	/** Get build info.
	* Return information about the current Flecs build.
	*
	* @return A struct with information about the current Flecs build.
	*/
	ecs_get_build_info :: proc() -> ^ecs_build_info_t ---

	/** Get the world info.
	*
	* @param world The world.
	* @return A pointer to the world info. Valid for as long as the world exists.
	*/
	ecs_get_world_info :: proc(world: ^ecs_world_t) -> ^ecs_world_info_t ---

	/** Dimension the world for a specified number of entities.
	* This operation will preallocate memory in the world for the specified number
	* of entities. Specifying a number lower than the current number of entities in
	* the world will have no effect.
	*
	* @param world The world.
	* @param entity_count The number of entities to preallocate.
	*/
	ecs_dim :: proc(world: ^ecs_world_t, entity_count: i32) ---

	/** Free unused memory.
	* This operation frees allocated memory that is no longer in use by the world.
	* Examples of allocations that get cleaned up are:
	* - Unused pages in the entity index
	* - Component columns
	* - Empty tables
	*
	* Flecs uses allocators internally for speeding up allocations. Allocators are
	* not evaluated by this function, which means that the memory reported by the
	* OS may not go down. For this reason, this function is most effective when
	* combined with FLECS_USE_OS_ALLOC, which disables internal allocators.
	*
	* @param world The world.
	*/
	ecs_shrink :: proc(world: ^ecs_world_t) ---

	/** Create a new entity range.
	* This function creates a range that constrains new entity identifiers returned
	* by the specified [min, max] interval. Each range maintains its own list of
	* recycled entity ids, which ensures that recycled ids always respect the
	* configured range. If `max` is set to 0, the range is unbounded.
	*
	* Entity ranges cannot be deleted once created. Use ecs_entity_range_set() to
	* activate a range.
	*
	* @param world The world.
	* @param min The first entity id in the range (inclusive).
	* @param max The last entity id in the range (inclusive, 0 = unlimited).
	* @return A pointer to the new range. Does not need to be freed.
	*/
	ecs_entity_range_new :: proc(world: ^ecs_world_t, min: u32, max: u32) -> ^ecs_entity_range_t ---

	/** Set the active entity range.
	* This function activates a range created with ecs_entity_range_new().
	* When a range is activated, new entity identifiers will fall within the
	* specified [min, max] interval, including recycled identifiers.
	*
	* When the active range is out of available ids, operations that create new
	* entity ids will assert.
	*
	* The operation only accepts ranges that have been created by
	* ecs_entity_range_new().
	*
	* @param world The world.
	* @param range The range to activate.
	*/
	ecs_entity_range_set :: proc(world: ^ecs_world_t, range: ^ecs_entity_range_t) ---

	/** Get the currently active entity id range.
	* Returns the range set by ecs_entity_range_set(), or NULL if no range is
	* active.
	*
	* @param world The world.
	* @return The active range, or NULL.
	*/
	ecs_entity_range_get :: proc(world: ^ecs_world_t) -> ^ecs_entity_range_t ---

	/** Get the largest issued entity ID (not counting generation).
	*
	* @param world The world.
	* @return The largest issued entity ID.
	*/
	ecs_get_max_id :: proc(world: ^ecs_world_t) -> ecs_entity_t ---

	/** Force aperiodic actions.
	* The world may delay certain operations until they are necessary for the
	* application to function correctly. This may cause observable side effects
	* such as delayed triggering of events, which can be inconvenient when, for
	* example, running a test suite.
	*
	* The flags parameter specifies which aperiodic actions to run. Specify 0 to
	* run all actions. Supported flags start with 'EcsAperiodic'. Flags identify
	* internal mechanisms and may change unannounced.
	*
	* @param world The world.
	* @param flags The flags specifying which actions to run.
	*/
	ecs_run_aperiodic :: proc(world: ^ecs_world_t, flags: ecs_flags32_t) ---
}

/** Used with ecs_delete_empty_tables(). */
ecs_delete_empty_tables_desc_t :: struct {
	/** Free table data when generation > clear_generation. */
	clear_generation: u16,

	/** Delete table when generation > delete_generation. */
	delete_generation: u16,

	/** Amount of time operation is allowed to spend. */
	time_budget_seconds: f64,

	/** Table index to start scanning at. The function loops around until it
	* reaches this offset again, or until the time budget is exceeded. */
	offset: i32,
}

@(default_calling_convention="c")
foreign lib {
	/** Clean up empty tables.
	* This operation cleans up empty tables that meet certain conditions. Having
	* large amounts of empty tables does not negatively impact performance of the
	* ECS, but can take up considerable amounts of memory, especially in
	* applications with many components, and many components per entity.
	*
	* The generation specifies the minimum number of times this operation has
	* to be called before an empty table is cleaned up. If a table becomes
	* non-empty, the generation is reset.
	*
	* The operation allows for both a "clear" generation and a "delete"
	* generation. When the clear generation is reached, the table's
	* resources are freed (like component arrays) but the table itself is not
	* deleted. When the delete generation is reached, the empty table is deleted.
	*
	* By specifying a non-zero ID, the cleanup logic can be limited to tables with
	* a specific (component) ID. The operation will only increase the generation
	* count of matching tables.
	*
	* The min_id_count specifies a lower bound for the number of components a table
	* should have. Often the more components a table has, the more specific it is
	* and therefore less likely to be reused.
	*
	* The time budget specifies how long the operation should take at most.
	*
	* The offset parameter specifies the table index at which to start scanning.
	* The function loops around until it reaches this offset again, or until the
	* time budget is exceeded.
	*
	* @param world The world.
	* @param desc Configuration parameters.
	* @return The index + 1 of the table where the function stopped, or 0 if the
	*         function scanned all tables. The return value can be used as the
	*         offset for the next call.
	*/
	ecs_delete_empty_tables :: proc(world: ^ecs_world_t, desc: ^ecs_delete_empty_tables_desc_t) -> i32 ---

	/** Get the world from a poly.
	*
	* @param poly A pointer to a poly object.
	* @return The world.
	*/
	ecs_get_world :: proc(poly: ^ecs_poly_t) -> ^ecs_world_t ---

	/** Get the entity from a poly.
	*
	* @param poly A pointer to a poly object.
	* @return The entity associated with the poly object.
	*/
	ecs_get_entity :: proc(poly: ^ecs_poly_t) -> ecs_entity_t ---

	/** Test if a pointer is of the specified type.
	* Usage:
	*
	* @code
	* flecs_poly_is(ptr, ecs_world_t)
	* @endcode
	*
	* This operation only works for poly types.
	*
	* @param object The object to test.
	* @param type The ID of the type.
	* @return True if the pointer is of the specified type.
	*/
	flecs_poly_is_ :: proc(object: ^ecs_poly_t, type: i32) -> bool ---

	/** Make a pair ID.
	* This function is equivalent to using the ecs_pair() macro, and is added for
	* convenience to make it easier for non-C/C++ bindings to work with pairs.
	*
	* @param first The first element of the pair.
	* @param second The target of the pair.
	* @return A pair ID.
	*/
	ecs_make_pair :: proc(first: ecs_entity_t, second: ecs_entity_t) -> ecs_id_t ---

	/** Begin exclusive thread access.
	* This operation ensures that only the thread from which this operation is
	* called can access the world. Attempts to access the world from other threads
	* will panic.
	*
	* ecs_exclusive_access_begin() must be called in pairs with
	* ecs_exclusive_access_end(). Calling ecs_exclusive_access_begin() from another
	* thread without first calling ecs_exclusive_access_end() will panic.
	*
	* A thread name can be provided to the function to improve debug messages. The
	* function does not copy the thread name, which means the memory for the
	* name must remain alive for as long as the thread has exclusive access.
	*
	* This operation should only be called once per thread. Calling it multiple
	* times for the same thread will cause a panic.
	*
	* Note that this feature only works in builds where asserts are enabled. The
	* feature requires the OS API thread_self_ callback to be set.
	*
	* @param world The world.
	* @param thread_name The name of the thread obtaining exclusive access.
	*/
	ecs_exclusive_access_begin :: proc(world: ^ecs_world_t, thread_name: cstring) ---

	/** End exclusive thread access.
	* This operation should be called after ecs_exclusive_access_begin(). After
	* calling this operation, other threads are no longer prevented from mutating
	* the world.
	*
	* When "lock_world" is set to true, no thread will be able to mutate the world
	* until ecs_exclusive_access_begin() is called again. While the world is locked,
	* only read-only operations are allowed. For example, ecs_get_id() is allowed,
	* but ecs_get_mut_id() is not allowed.
	*
	* A locked world can be unlocked by calling ecs_exclusive_access_end() again with
	* lock_world set to false. Note that this only works for locked worlds. If
	* ecs_exclusive_access_end() is called on a world that has exclusive thread
	* access from a different thread, a panic will happen.
	*
	* This operation must be called from the same thread that called
	* ecs_exclusive_access_begin(). Calling it from a different thread will cause
	* a panic.
	*
	* @param world The world.
	* @param lock_world When true, any mutations on the world will be blocked.
	*/
	ecs_exclusive_access_end :: proc(world: ^ecs_world_t, lock_world: bool) ---

	/** Create new entity ID.
	* This operation returns an unused entity ID. This operation is guaranteed to
	* return an empty entity as it does not use values set by ecs_set_scope() or
	* ecs_set_with().
	*
	* @param world The world.
	* @return The new entity ID.
	*/
	ecs_new :: proc(world: ^ecs_world_t) -> ecs_entity_t ---

	/** Create new low ID.
	* This operation returns a new low ID. Entity IDs start after the
	* FLECS_HI_COMPONENT_ID constant. This reserves a range of low IDs for things
	* like components, and allows parts of the code to optimize operations.
	*
	* Note that FLECS_HI_COMPONENT_ID does not represent the maximum number of
	* components that can be created, only the maximum number of components that
	* can take advantage of these optimizations.
	*
	* This operation is guaranteed to return an empty entity as it does not use
	* values set by ecs_set_scope() or ecs_set_with().
	*
	* This operation does not recycle IDs.
	*
	* @param world The world.
	* @return The new component ID.
	*/
	ecs_new_low_id :: proc(world: ^ecs_world_t) -> ecs_entity_t ---

	/** Create new entity with (component) ID.
	* This operation creates a new entity with an optional (component) ID.
	*
	* @param world The world.
	* @param component The component to create the new entity with.
	* @return The new entity.
	*/
	ecs_new_w_id :: proc(world: ^ecs_world_t, component: ecs_id_t) -> ecs_entity_t ---

	/** Create new entity in table.
	* This operation creates a new entity in the specified table.
	*
	* @param world The world.
	* @param table The table to which to add the new entity.
	* @return The new entity.
	*/
	ecs_new_w_table :: proc(world: ^ecs_world_t, table: ^ecs_table_t) -> ecs_entity_t ---

	/** Find or create an entity.
	* This operation creates a new entity, or modifies an existing one. When a name
	* is set in the ecs_entity_desc_t::name field and ecs_entity_desc_t::entity is
	* not set, the operation will first attempt to find an existing entity by that
	* name. If no entity with that name can be found, it will be created.
	*
	* If both a name and entity handle are provided, the operation will check if
	* the entity name matches with the provided name. If the names do not match,
	* the function will fail and return 0.
	*
	* If an ID to a non-existing entity is provided, that entity ID becomes alive.
	*
	* See the documentation of ecs_entity_desc_t for more details.
	*
	* @param world The world.
	* @param desc Entity init parameters.
	* @return A handle to the new or existing entity, or 0 if failed.
	*/
	ecs_entity_init :: proc(world: ^ecs_world_t, desc: ^ecs_entity_desc_t) -> ecs_entity_t ---

	/** Bulk create or populate new entities.
	* This operation bulk inserts a list of new or predefined entities into a
	* single table.
	*
	* The operation does not take ownership of component arrays provided by the
	* application. Components that are non-trivially copyable will be moved into
	* the storage.
	*
	* The operation will emit OnAdd events for each added ID, and OnSet events for
	* each component that has been set.
	*
	* If no entity IDs are provided by the application, the returned array of IDs
	* points to an internal data structure, which changes when new entities are
	* created or deleted.
	*
	* If as a result of the operation, observers are invoked that delete
	* entities and no entity IDs were provided by the application, the returned
	* array of identifiers may be incorrect. To avoid this problem, an application
	* can first call ecs_bulk_init() to create empty entities, copy the array to one
	* that is owned by the application, and then use this array to populate the
	* entities.
	*
	* @param world The world.
	* @param desc Bulk creation parameters.
	* @return An array with the list of entity IDs created or populated.
	*/
	ecs_bulk_init :: proc(world: ^ecs_world_t, desc: ^ecs_bulk_desc_t) -> ^ecs_entity_t ---

	/** Create N new entities.
	* This operation is the same as ecs_new_w_id(), but creates N entities
	* instead of one.
	*
	* @param world The world.
	* @param component The component to create the entities with.
	* @param count The number of entities to create.
	* @return An array with the entity IDs of the newly created entities.
	*/
	ecs_bulk_new_w_id :: proc(world: ^ecs_world_t, component: ecs_id_t, count: i32) -> ^ecs_entity_t ---

	/** Clone an entity.
	* This operation clones the components of one entity into another entity. If
	* no destination entity is provided, a new entity will be created. Component
	* values are not copied unless copy_value is true.
	*
	* If the source entity has a name, it will not be copied to the destination
	* entity. This is to prevent having two entities with the same name under the
	* same parent, which is not allowed.
	*
	* @param world The world.
	* @param dst The entity to copy the components to.
	* @param src The entity to copy the components from.
	* @param copy_value If true, the value of components will be copied to dst.
	* @return The destination entity.
	*/
	ecs_clone :: proc(world: ^ecs_world_t, dst: ecs_entity_t, src: ecs_entity_t, copy_value: bool) -> ecs_entity_t ---

	/** Delete an entity.
	* This operation will delete an entity and all of its components. The entity ID
	* will be made available for recycling. If the entity passed to ecs_delete() is
	* not alive, the operation will have no side effects.
	*
	* @param world The world.
	* @param entity The entity.
	*/
	ecs_delete :: proc(world: ^ecs_world_t, entity: ecs_entity_t) ---

	/** Delete all entities with the specified component.
	* This will delete all entities (tables) that have the specified ID. The
	* component may be a wildcard and/or a pair.
	*
	* @param world The world.
	* @param component The component.
	*/
	ecs_delete_with :: proc(world: ^ecs_world_t, component: ecs_id_t) ---

	/** Set child order for parent with OrderedChildren.
	* If the parent has the OrderedChildren trait, the order of the children
	* will be updated to the order in the specified children array. The operation
	* will fail if the parent does not have the OrderedChildren trait.
	*
	* This operation always takes place immediately, and is not deferred. When the
	* operation is called from a multithreaded system, it will fail.
	*
	* The reason for not deferring this operation is that by the time the deferred
	* command would be executed, the children of the parent could have been changed
	* which would cause the operation to fail.
	*
	* @param world The world.
	* @param parent The parent.
	* @param children An array with children.
	* @param child_count The number of children in the provided array.
	*/
	ecs_set_child_order :: proc(world: ^ecs_world_t, parent: ecs_entity_t, children: ^ecs_entity_t, child_count: i32) ---

	/** Get ordered children.
	* If a parent has the OrderedChildren trait, this operation can be used to
	* obtain the array with child entities. If this operation is used on a parent
	* that does not have the OrderedChildren trait, it will fail.
	*
	* @param world The world.
	* @param parent The parent.
	* @return The array with child entities.
	*/
	ecs_get_ordered_children :: proc(world: ^ecs_world_t, parent: ecs_entity_t) -> ecs_entities_t ---

	/** Add a (component) ID to an entity.
	* This operation adds a single (component) ID to an entity. If the entity
	* already has the ID, this operation will have no side effects.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component ID to add.
	*/
	ecs_add_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) ---

	/** Remove a component from an entity.
	* This operation removes a single component from an entity. If the entity
	* does not have the component, this operation will have no side effects.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to remove.
	*/
	ecs_remove_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) ---

	/** Add an auto override for a component.
	* An auto override is a component that is automatically added to an entity when
	* it is instantiated from a prefab. Auto overrides are added to the entity that
	* is inherited from (usually a prefab). For example:
	*
	* @code
	* ecs_entity_t prefab = ecs_insert(world,
	*   ecs_value(Position, {10, 20}),
	*   ecs_value(Mass, {100}));
	*
	* ecs_auto_override(world, prefab, Position);
	*
	* ecs_entity_t inst = ecs_new_w_pair(world, EcsIsA, prefab);
	* assert(ecs_owns(world, inst, Position)); // true
	* assert(ecs_owns(world, inst, Mass)); // false
	* @endcode
	*
	* An auto override is equivalent to a manual override:
	*
	* @code
	* ecs_entity_t prefab = ecs_insert(world,
	*   ecs_value(Position, {10, 20}),
	*   ecs_value(Mass, {100}));
	*
	* ecs_entity_t inst = ecs_new_w_pair(world, EcsIsA, prefab);
	* assert(ecs_owns(world, inst, Position)); // false
	* ecs_add(world, inst, Position); // manual override
	* assert(ecs_owns(world, inst, Position)); // true
	* assert(ecs_owns(world, inst, Mass)); // false
	* @endcode
	*
	* This operation is equivalent to manually adding the ID with the AUTO_OVERRIDE
	* bit applied:
	*
	* @code
	* ecs_add_id(world, entity, ECS_AUTO_OVERRIDE | id);
	* @endcode
	*
	* When a component is overridden and inherited from a prefab, the value from
	* the prefab component is copied to the instance. When the component is not
	* inherited from a prefab, it is added to the instance as if using ecs_add_id().
	*
	* Overriding is the default behavior on prefab instantiation. Auto overriding
	* is only useful for components with the `(OnInstantiate, Inherit)` trait.
	* When a component has the `(OnInstantiate, DontInherit)` trait and is overridden,
	* the component is added, but the value from the prefab will not be copied.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to auto override.
	*/
	ecs_auto_override_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) ---

	/** Clear all components.
	* This operation will remove all components from an entity.
	*
	* @param world The world.
	* @param entity The entity.
	*/
	ecs_clear :: proc(world: ^ecs_world_t, entity: ecs_entity_t) ---

	/** Remove all instances of the specified component.
	* This will remove the specified ID from all entities (tables). The ID may be
	* a wildcard and/or a pair.
	*
	* @param world The world.
	* @param component The component.
	*/
	ecs_remove_all :: proc(world: ^ecs_world_t, component: ecs_id_t) ---

	/** Create new entities with a specified component.
	* This operation configures a component that is automatically added to entities
	* created with ecs_entity_init(). This does not apply to entities created with
	* ecs_new().
	*
	* Only one component can be specified at a time. If this operation is called
	* while a component is already configured, the new component will override the
	* old component.
	*
	* @param world The world.
	* @param component The component.
	* @return The previously set component.
	* @see ecs_entity_init()
	* @see ecs_get_with()
	*/
	ecs_set_with :: proc(world: ^ecs_world_t, component: ecs_id_t) -> ecs_entity_t ---

	/** Get the component set with ecs_set_with().
	* This operation returns the component that was previously provided to
	* ecs_set_with().
	*
	* @param world The world.
	* @return The last component provided to ecs_set_with().
	* @see ecs_set_with()
	*/
	ecs_get_with :: proc(world: ^ecs_world_t) -> ecs_id_t ---

	/** Enable or disable an entity.
	* This operation enables or disables an entity by adding or removing the
	* #EcsDisabled tag. A disabled entity will not be matched with any systems,
	* unless the system explicitly specifies the #EcsDisabled tag.
	*
	* @param world The world.
	* @param entity The entity to enable or disable.
	* @param enabled true to enable the entity, false to disable.
	*/
	ecs_enable :: proc(world: ^ecs_world_t, entity: ecs_entity_t, enabled: bool) ---

	/** Enable or disable a component.
	* Enabling or disabling a component does not add or remove a component from an
	* entity, but prevents it from being matched with queries. This operation can
	* be useful when a component must be temporarily disabled without destroying
	* its value. It is also a more performant operation for when an application
	* needs to add/remove components at high frequency, as enabling/disabling is
	* cheaper than a regular add or remove.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to enable/disable.
	* @param enable True to enable the component, false to disable.
	*/
	ecs_enable_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t, enable: bool) ---

	/** Test if a component is enabled.
	* Test whether a component is currently enabled or disabled. This operation
	* will return true when the entity has the component and if it has not been
	* disabled by ecs_enable_id().
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component.
	* @return True if the component is enabled, otherwise false.
	*/
	ecs_is_enabled_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) -> bool ---

	/** Get an immutable pointer to a component.
	* This operation obtains a const pointer to the requested component. The
	* operation accepts the component entity ID.
	*
	* This operation can return inherited components reachable through an `IsA`
	* relationship.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get.
	* @return The component pointer, NULL if the entity does not have the component.
	*
	* @see ecs_get_mut_id()
	*/
	ecs_get_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) -> rawptr ---

	/** Get a mutable pointer to a component.
	* This operation obtains a mutable pointer to the requested component. The
	* operation accepts the component entity ID.
	*
	* Unlike ecs_get_id(), this operation does not return inherited components.
	* This is to prevent errors where an application accidentally resolves an
	* inherited component shared with many entities and modifies it, while thinking
	* it is modifying an owned component.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get.
	* @return The component pointer, NULL if the entity does not have the component.
	*/
	ecs_get_mut_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) -> rawptr ---

	/** Ensure an entity has a component and return a pointer.
	* This operation returns a mutable pointer to a component. If the entity did
	* not yet have the component, it will be added.
	*
	* If ensure() is called when the world is in deferred or read-only mode, the
	* function will:
	* - return a pointer to temporary storage if the component does not yet exist, or
	* - return a pointer to the existing component if it exists
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get or add.
	* @param size The size of the component.
	* @return The component pointer.
	*
	* @see ecs_emplace_id()
	*/
	ecs_ensure_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t, size: c.size_t) -> rawptr ---

	/** Create a component ref.
	* A ref is a handle to an entity and component pair, which caches a small amount of
	* data to reduce the overhead of repeatedly accessing the component. Use
	* ecs_ref_get() to get the component data.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to create a ref for.
	* @return The reference.
	*/
	ecs_ref_init_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) -> ecs_ref_t ---

	/** Get a component from a ref.
	* Get a component pointer from a ref. The ref must be created with ecs_ref_init().
	* The specified component must match the component with which the ref was
	* created.
	*
	* @param world The world.
	* @param ref The ref.
	* @param component The component to get.
	* @return The component pointer, NULL if the entity does not have the component.
	*/
	ecs_ref_get_id :: proc(world: ^ecs_world_t, ref: ^ecs_ref_t, component: ecs_id_t) -> rawptr ---

	/** Update a ref.
	* Ensure the contents of a ref are up to date. Same as ecs_ref_get_id(), but does not
	* return a pointer to the component.
	*
	* @param world The world.
	* @param ref The ref.
	* @param component The component the ref was created with.
	*/
	ecs_ref_update :: proc(world: ^ecs_world_t, ref: ^ecs_ref_t, component: ecs_id_t) ---

	/** Emplace a component.
	* Emplace is similar to ecs_ensure_id() except that the component constructor
	* is not invoked for the returned pointer, allowing the component to be
	* constructed directly in the storage.
	*
	* When the `is_new` parameter is not provided, the operation will assert when the
	* component already exists. When the `is_new` parameter is provided, it will
	* indicate whether the returned storage has been constructed.
	*
	* When `is_new` indicates that the storage has not yet been constructed, it must
	* be constructed by the code invoking this operation. Not constructing the
	* component will result in undefined behavior.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to get or add.
	* @param size The component size.
	* @param is_new Whether this is an existing or new component.
	* @return The (uninitialized) component pointer.
	*/
	ecs_emplace_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t, size: c.size_t, is_new: ^bool) -> rawptr ---

	/** Signal that a component has been modified.
	* This operation is usually used after modifying a component value obtained by
	* ecs_ensure_id(). The operation will mark the component as dirty, and invoke
	* OnSet observers and hooks.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component that was modified.
	*/
	ecs_modified_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) ---

	/** Set the value of a component.
	* This operation allows an application to set the value of a component. The
	* operation is equivalent to calling ecs_ensure_id() followed by
	* ecs_modified_id(). The operation will not modify the value of the passed-in
	* component. If the component has a copy hook registered, it will be used to
	* copy in the component.
	*
	* If the provided entity is 0, a new entity will be created.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to set.
	* @param size The size of the pointed-to value.
	* @param ptr The pointer to the value.
	*/
	ecs_set_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t, size: c.size_t, ptr: rawptr) ---

	/** Test whether an entity is valid.
	* This operation tests whether the entity ID:
	* - is not 0
	* - has a valid bit pattern
	* - is alive (see ecs_is_alive())
	*
	* If this operation returns true, it is safe to use the entity with
	* other operations.
	*
	* This operation should only be used if an application cannot be sure that an
	* entity is initialized with a valid value. In all other cases where an entity
	* was initialized with a valid value, but the application wants to check if the
	* entity is (still) alive, use ecs_is_alive().
	*
	* @param world The world.
	* @param e The entity.
	* @return True if the entity is valid, false if the entity is not valid.
	* @see ecs_is_alive()
	*/
	ecs_is_valid :: proc(world: ^ecs_world_t, e: ecs_entity_t) -> bool ---

	/** Test whether an entity is alive.
	* Entities are alive after they are created, and become not alive when they are
	* deleted. Operations that return alive IDs are (amongst others) ecs_new(),
	* ecs_new_low_id() and ecs_entity_init(). IDs can be made alive with the
	* ecs_make_alive() function.
	*
	* After an ID is deleted it can be recycled. Recycled IDs are different from
	* the original ID in that they have a different generation count. This makes it
	* possible for the API to distinguish between the two. An example:
	*
	* @code
	* ecs_entity_t e1 = ecs_new(world);
	* ecs_is_alive(world, e1);             // true
	* ecs_delete(world, e1);
	* ecs_is_alive(world, e1);             // false
	*
	* ecs_entity_t e2 = ecs_new(world);    // recycles e1
	* ecs_is_alive(world, e2);             // true
	* ecs_is_alive(world, e1);             // false
	* @endcode
	*
	* Unlike ecs_is_valid(), this operation will panic if the passed-in entity
	* ID is 0 or has an invalid bit pattern.
	*
	* @param world The world.
	* @param e The entity.
	* @return True if the entity is alive, false if the entity is not alive.
	* @see ecs_is_valid()
	*/
	ecs_is_alive :: proc(world: ^ecs_world_t, e: ecs_entity_t) -> bool ---

	/** Remove the generation from an entity ID.
	*
	* @param e The entity ID.
	* @return The entity ID without the generation count.
	*/
	ecs_strip_generation :: proc(e: ecs_entity_t) -> ecs_id_t ---

	/** Get an alive identifier.
	* In some cases an application may need to work with identifiers from which
	* the generation has been stripped. A typical scenario in which this happens is
	* when iterating relationships in an entity type.
	*
	* For example, when obtaining the parent ID from a `ChildOf` relationship, the parent
	* (second element of the pair) will have been stored in a 32-bit value, which
	* cannot store the entity generation. This function can retrieve the identifier
	* with the current generation for that ID.
	*
	* If the provided identifier is not alive, the function will return 0.
	*
	* @param world The world.
	* @param e The entity for which to obtain the current alive entity ID.
	* @return The alive entity ID if there is one, or 0 if the ID is not alive.
	*/
	ecs_get_alive :: proc(world: ^ecs_world_t, e: ecs_entity_t) -> ecs_entity_t ---

	/** Ensure an ID is alive.
	* This operation ensures that the provided ID is alive. This is useful in
	* scenarios where an application has an existing ID that has not been created
	* with ecs_new_w() (such as a global constant or an ID from a remote application).
	*
	* When this operation is successful, it guarantees that the provided ID exists,
	* is valid, and is alive.
	*
	* Before this operation, the ID must either not be alive or have a generation
	* that is equal to the passed-in entity.
	*
	* If the provided ID has a non-zero generation count and the ID does not exist
	* in the world, the ID will be created with the specified generation.
	*
	* If the provided ID is alive and has a generation count that does not match
	* the provided ID, the operation will fail.
	*
	* @param world The world.
	* @param entity The entity ID to make alive.
	*
	* @see ecs_make_alive_id()
	*/
	ecs_make_alive :: proc(world: ^ecs_world_t, entity: ecs_entity_t) ---

	/** Same as ecs_make_alive(), but for components.
	* An ID can be an entity or a pair, and can contain ID flags. This operation
	* ensures that the entity (or entities, for a pair) are alive.
	*
	* When this operation is successful, it guarantees that the provided ID can be
	* used in operations that accept an ID.
	*
	* Since entities in a pair do not encode their generation IDs, this operation
	* will not fail when an entity with non-zero generation count already exists in
	* the world.
	*
	* This is different from ecs_make_alive(), which will fail if attempted with an ID
	* that has generation 0 and an entity with a non-zero generation is currently
	* alive.
	*
	* @param world The world.
	* @param component The component to make alive.
	*/
	ecs_make_alive_id :: proc(world: ^ecs_world_t, component: ecs_id_t) ---

	/** Test whether an entity exists.
	* Similar to ecs_is_alive(), but ignores the entity generation count.
	*
	* @param world The world.
	* @param entity The entity.
	* @return True if the entity exists, false if the entity does not exist.
	*/
	ecs_exists :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> bool ---

	/** Override the generation of an entity.
	* The generation count of an entity is increased each time an entity is deleted
	* and is used to test whether an entity ID is alive.
	*
	* This operation overrides the current generation of an entity with the
	* specified generation, which can be useful if an entity is externally managed,
	* like for external pools, savefiles, or netcode.
	*
	* This operation is similar to ecs_make_alive(), except that it will also
	* override the generation of an alive entity.
	*
	* @param world The world.
	* @param entity The entity for which to set the generation.
	*/
	ecs_set_version :: proc(world: ^ecs_world_t, entity: ecs_entity_t) ---

	/** Get the generation of an entity.
	*
	* @param entity The entity for which to get the generation.
	* @return The generation of the entity.
	*/
	ecs_get_version :: proc(entity: ecs_entity_t) -> u32 ---

	/** Get the type of an entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The type of the entity, NULL if the entity has no components.
	*/
	ecs_get_type :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> ^ecs_type_t ---

	/** Get the table of an entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The table of the entity, NULL if the entity has no components or tags.
	*/
	ecs_get_table :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> ^ecs_table_t ---

	/** Convert a type to a string.
	* The result of this operation must be freed with ecs_os_free().
	*
	* @param world The world.
	* @param type The type.
	* @return The stringified type.
	*/
	ecs_type_str :: proc(world: ^ecs_world_t, type: ^ecs_type_t) -> cstring ---

	/** Convert a table to a string.
	* Same as `ecs_type_str(world, ecs_table_get_type(table))`. The result of this
	* operation must be freed with ecs_os_free().
	*
	* @param world The world.
	* @param table The table.
	* @return The stringified table type.
	*
	* @see ecs_table_get_type()
	* @see ecs_type_str()
	*/
	ecs_table_str :: proc(world: ^ecs_world_t, table: ^ecs_table_t) -> cstring ---

	/** Convert an entity to a string.
	* Same as combining:
	* - ecs_get_path(world, entity)
	* - ecs_type_str(world, ecs_get_type(world, entity))
	*
	* The result of this operation must be freed with ecs_os_free().
	*
	* @param world The world.
	* @param entity The entity.
	* @return The entity path with stringified type.
	*
	* @see ecs_get_path()
	* @see ecs_type_str()
	*/
	ecs_entity_str :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Test if an entity has a component.
	* This operation returns true if the entity has or inherits the component.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to test for.
	* @return True if the entity has the component, false if not.
	*
	* @see ecs_owns_id()
	*/
	ecs_has_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) -> bool ---

	/** Test if an entity owns a component.
	* This operation returns true if the entity has the component. The operation
	* behaves the same as ecs_has_id(), except that it will return false for
	* components that are inherited through an `IsA` relationship.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component to test for.
	* @return True if the entity has the component, false if not.
	*/
	ecs_owns_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t) -> bool ---

	/** Get the target of a relationship.
	* This will return a target (second element of a pair) of the entity for the
	* specified relationship. The index allows for iterating through the targets,
	* if a single entity has multiple targets for the same relationship.
	*
	* If the index is larger than the total number of instances the entity has for
	* the relationship, the operation will return 0.
	*
	* @param world The world.
	* @param entity The entity.
	* @param rel The relationship between the entity and the target.
	* @param index The index of the relationship instance.
	* @return The target for the relationship at the specified index.
	*/
	ecs_get_target :: proc(world: ^ecs_world_t, entity: ecs_entity_t, rel: ecs_entity_t, index: i32) -> ecs_entity_t ---

	/** Get the parent (target of the `ChildOf` relationship) for an entity.
	* This operation is the same as calling:
	*
	* @code
	* ecs_get_target(world, entity, EcsChildOf, 0);
	* @endcode
	*
	* @param world The world.
	* @param entity The entity.
	* @return The parent of the entity, 0 if the entity has no parent.
	*
	* @see ecs_get_target()
	*/
	ecs_get_parent :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> ecs_entity_t ---

	/** Create child with Parent component.
	* This creates or returns an existing child for the specified parent. If a new
	* child is created, the Parent component is used to create the parent
	* relationship.
	*
	* If a child entity already exists with the specified name, it will be
	* returned.
	*
	* @param world The world.
	* @param parent The parent for which to create the child.
	* @param name The name with which to create the entity (may be NULL).
	* @return A new or existing child entity.
	*/
	ecs_new_w_parent :: proc(world: ^ecs_world_t, parent: ecs_entity_t, name: cstring) -> ecs_entity_t ---

	/** Get the target of a relationship for a given component.
	* This operation returns the first entity that has the provided component by
	* following the relationship. If the entity itself has the component then it
	* will be returned. If the component cannot be found on the entity or by
	* following the relationship, the operation will return 0.
	*
	* This operation can be used to look up, for example, which prefab is providing
	* a component by specifying the `IsA` relationship:
	*
	* @code
	* // Is Position provided by the entity or one of its base entities?
	* ecs_get_target_for_id(world, entity, EcsIsA, ecs_id(Position))
	* @endcode
	*
	* @param world The world.
	* @param entity The entity.
	* @param rel The relationship to follow.
	* @param component The component to look up.
	* @return The entity for which the target has been found.
	*/
	ecs_get_target_for_id :: proc(world: ^ecs_world_t, entity: ecs_entity_t, rel: ecs_entity_t, component: ecs_id_t) -> ecs_entity_t ---

	/** Return the depth for an entity in the tree for the specified relationship.
	* Depth is determined by counting the number of targets encountered while
	* traversing up the relationship tree for `rel`. Only acyclic relationships are
	* supported.
	*
	* @param world The world.
	* @param entity The entity.
	* @param rel The relationship.
	* @return The depth of the entity in the tree.
	*/
	ecs_get_depth :: proc(world: ^ecs_world_t, entity: ecs_entity_t, rel: ecs_entity_t) -> i32 ---

	/** Count entities that have the specified ID.
	* Return the number of entities that have the specified ID.
	*
	* @param world The world.
	* @param entity The ID to search for.
	* @return The number of entities that have the ID.
	*/
	ecs_count_id :: proc(world: ^ecs_world_t, entity: ecs_id_t) -> i32 ---

	/** Get the name of an entity.
	* This will return the name stored in `(EcsIdentifier, EcsName)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The name of the entity, NULL if the entity has no name.
	*
	* @see ecs_set_name()
	*/
	ecs_get_name :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Get the symbol of an entity.
	* This will return the symbol stored in `(EcsIdentifier, EcsSymbol)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @return The symbol of the entity, NULL if the entity has no symbol.
	*
	* @see ecs_set_symbol()
	*/
	ecs_get_symbol :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Set the name of an entity.
	* This will set or overwrite the name of an entity. If no entity is provided,
	* a new entity will be created.
	*
	* The name is stored in `(EcsIdentifier, EcsName)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @param name The name.
	* @return The provided entity, or a new entity if 0 was provided.
	*
	* @see ecs_get_name()
	*/
	ecs_set_name :: proc(world: ^ecs_world_t, entity: ecs_entity_t, name: cstring) -> ecs_entity_t ---

	/** Set the symbol of an entity.
	* This will set or overwrite the symbol of an entity. If no entity is provided,
	* a new entity will be created.
	*
	* The symbol is stored in `(EcsIdentifier, EcsSymbol)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @param symbol The symbol.
	* @return The provided entity, or a new entity if 0 was provided.
	*
	* @see ecs_get_symbol()
	*/
	ecs_set_symbol :: proc(world: ^ecs_world_t, entity: ecs_entity_t, symbol: cstring) -> ecs_entity_t ---

	/** Set an alias for an entity.
	* An entity can be looked up using its alias from the root scope without
	* providing the fully qualified name of its parent. An entity can only have
	* a single alias.
	*
	* The alias is stored in `(EcsIdentifier, EcsAlias)`.
	*
	* @param world The world.
	* @param entity The entity.
	* @param alias The alias.
	*/
	ecs_set_alias :: proc(world: ^ecs_world_t, entity: ecs_entity_t, alias: cstring) ---

	/** Look up an entity by its path.
	* This operation is equivalent to calling:
	*
	* @code
	* ecs_lookup_path_w_sep(world, 0, path, ".", NULL, true);
	* @endcode
	*
	* @param world The world.
	* @param path The entity path.
	* @return The entity with the specified path, or 0 if no entity was found.
	*
	* @see ecs_lookup_child()
	* @see ecs_lookup_path_w_sep()
	* @see ecs_lookup_symbol()
	*/
	ecs_lookup :: proc(world: ^ecs_world_t, path: cstring) -> ecs_entity_t ---

	/** Look up a child entity by name.
	* Return an entity that matches the specified name. Only look for entities in
	* the provided parent. If no parent is provided, look in the current scope
	* (root if no scope is provided).
	*
	* @param world The world.
	* @param parent The parent for which to look up the child.
	* @param name The entity name.
	* @return The entity with the specified name, or 0 if no entity was found.
	*
	* @see ecs_lookup()
	* @see ecs_lookup_path_w_sep()
	* @see ecs_lookup_symbol()
	*/
	ecs_lookup_child :: proc(world: ^ecs_world_t, parent: ecs_entity_t, name: cstring) -> ecs_entity_t ---

	/** Look up an entity from a path.
	* Look up an entity from a provided path, relative to the provided parent. The
	* operation will use the provided separator to tokenize the path expression. If
	* the provided path contains the prefix, the search will start from the root.
	*
	* If the entity is not found in the provided parent, the operation will
	* continue to search in the parent of the parent, until the root is reached. If
	* the entity is still not found, the lookup will search in the `flecs.core`
	* scope. If the entity is not found there either, the function returns 0.
	*
	* @param world The world.
	* @param parent The entity from which to resolve the path.
	* @param path The path to resolve.
	* @param sep The path separator.
	* @param prefix The path prefix.
	* @param recursive Recursively traverse up the tree until the entity is found.
	* @return The entity if found, else 0.
	*
	* @see ecs_lookup()
	* @see ecs_lookup_child()
	* @see ecs_lookup_symbol()
	*/
	ecs_lookup_path_w_sep :: proc(world: ^ecs_world_t, parent: ecs_entity_t, path: cstring, sep: cstring, prefix: cstring, recursive: bool) -> ecs_entity_t ---

	/** Look up an entity by its symbol name.
	* This looks up an entity by the symbol stored in `(EcsIdentifier, EcsSymbol)`. The
	* operation does not take into account hierarchies.
	*
	* This operation can be useful to resolve, for example, a type by its C
	* identifier, which does not include the Flecs namespacing.
	*
	* @param world The world.
	* @param symbol The symbol.
	* @param lookup_as_path If not found as a symbol, look up as path.
	* @param recursive If looking up as path, recursively traverse up the tree.
	* @return The entity if found, else 0.
	*
	* @see ecs_lookup()
	* @see ecs_lookup_child()
	* @see ecs_lookup_path_w_sep()
	*/
	ecs_lookup_symbol :: proc(world: ^ecs_world_t, symbol: cstring, lookup_as_path: bool, recursive: bool) -> ecs_entity_t ---

	/** Get a path identifier for an entity.
	* This operation creates a path that contains the names of the entities from
	* the specified parent to the provided entity, separated by the provided
	* separator. If no parent is provided, the path will be relative to the root. If
	* a prefix is provided, the path will be prefixed by the prefix.
	*
	* If the parent is equal to the provided child, the operation will return an
	* empty string. If a non-zero component is provided, the path will be created by
	* looking for parents with that component.
	*
	* The returned path should be freed by the application.
	*
	* @param world The world.
	* @param parent The entity from which to create the path.
	* @param child The entity to which to create the path.
	* @param sep The separator to use between path elements.
	* @param prefix The initial character to use for root elements.
	* @return The relative entity path.
	*
	* @see ecs_get_path_w_sep_buf()
	*/
	ecs_get_path_w_sep :: proc(world: ^ecs_world_t, parent: ecs_entity_t, child: ecs_entity_t, sep: cstring, prefix: cstring) -> cstring ---

	/** Write a path identifier to a buffer.
	* Same as ecs_get_path_w_sep(), but writes the result to an `ecs_strbuf_t`.
	*
	* @param world The world.
	* @param parent The entity from which to create the path.
	* @param child The entity to which to create the path.
	* @param sep The separator to use between path elements.
	* @param prefix The initial character to use for root elements.
	* @param buf The buffer to write to.
	* @param escape Whether to escape separator characters in names.
	*
	* @see ecs_get_path_w_sep()
	*/
	ecs_get_path_w_sep_buf :: proc(world: ^ecs_world_t, parent: ecs_entity_t, child: ecs_entity_t, sep: cstring, prefix: cstring, buf: ^ecs_strbuf_t, escape: bool) ---

	/** Find or create an entity from a path.
	* This operation will find or create an entity from a path, and will create any
	* intermediate entities if required. If the entity already exists, no entities
	* will be created.
	*
	* If the path starts with the prefix, then the entity will be created from the
	* root scope.
	*
	* @param world The world.
	* @param parent The entity relative to which the entity should be created.
	* @param path The path to create the entity for.
	* @param sep The separator used in the path.
	* @param prefix The prefix used in the path.
	* @return The entity.
	*/
	ecs_new_from_path_w_sep :: proc(world: ^ecs_world_t, parent: ecs_entity_t, path: cstring, sep: cstring, prefix: cstring) -> ecs_entity_t ---

	/** Add a specified path to an entity.
	* This operation is similar to ecs_new_from_path(), but will instead add the path
	* to an existing entity.
	*
	* If an entity already exists for the path, it will be returned instead.
	*
	* @param world The world.
	* @param entity The entity to which to add the path.
	* @param parent The entity relative to which the entity should be created.
	* @param path The path to create the entity for.
	* @param sep The separator used in the path.
	* @param prefix The prefix used in the path.
	* @return The entity.
	*/
	ecs_add_path_w_sep :: proc(world: ^ecs_world_t, entity: ecs_entity_t, parent: ecs_entity_t, path: cstring, sep: cstring, prefix: cstring) -> ecs_entity_t ---

	/** Set the current scope.
	* This operation sets the scope of the current stage to the provided entity.
	* As a result, new entities will be created in this scope, and lookups will be
	* relative to the provided scope.
	*
	* It is considered good practice to restore the scope to the old value.
	*
	* @param world The world.
	* @param scope The entity to use as scope.
	* @return The previous scope.
	*
	* @see ecs_get_scope()
	*/
	ecs_set_scope :: proc(world: ^ecs_world_t, scope: ecs_entity_t) -> ecs_entity_t ---

	/** Get the current scope.
	* Get the scope set by ecs_set_scope(). If no scope is set, this operation will
	* return 0.
	*
	* @param world The world.
	* @return The current scope.
	*/
	ecs_get_scope :: proc(world: ^ecs_world_t) -> ecs_entity_t ---

	/** Set a name prefix for newly created entities.
	* This is a utility that lets C modules use prefixed names for C types and
	* C functions, while using names for the entity names that do not have the
	* prefix. The name prefix is currently only used by `ECS_COMPONENT`.
	*
	* @param world The world.
	* @param prefix The name prefix to use.
	* @return The previous prefix.
	*/
	ecs_set_name_prefix :: proc(world: ^ecs_world_t, prefix: cstring) -> cstring ---

	/** Set the search path for lookup operations.
	* This operation accepts an array of entity IDs that will be used as search
	* scopes by lookup operations. The operation returns the current search path.
	* It is good practice to restore the old search path.
	*
	* The search path will be evaluated starting from the last element.
	*
	* The default search path includes `flecs.core`. When a custom search path is
	* provided, it overwrites the existing search path. Operations that rely on
	* looking up names from `flecs.core` without providing the namespace may fail if
	* the custom search path does not include `flecs.core` (`EcsFlecsCore`).
	*
	* The search path array is not copied into managed memory. The application must
	* ensure that the provided array is valid for as long as it is used as the
	* search path.
	*
	* The provided array must be terminated with a 0 element. This enables an
	* application to push or pop elements to an existing array without invoking the
	* ecs_set_lookup_path() operation again.
	*
	* @param world The world.
	* @param lookup_path 0-terminated array with entity IDs for the lookup path.
	* @return The current lookup path array.
	*
	* @see ecs_get_lookup_path()
	*/
	ecs_set_lookup_path :: proc(world: ^ecs_world_t, lookup_path: ^ecs_entity_t) -> ^ecs_entity_t ---

	/** Get the current lookup path.
	* Return the value set by ecs_set_lookup_path().
	*
	* @param world The world.
	* @return The current lookup path.
	*/
	ecs_get_lookup_path :: proc(world: ^ecs_world_t) -> ^ecs_entity_t ---

	/** Find or create a component.
	* This operation creates a new component, or finds an existing one. The find or
	* create behavior is the same as ecs_entity_init().
	*
	* When an existing component is found, the size and alignment are verified with
	* the provided values. If the values do not match, the operation will fail.
	*
	* See the documentation of ecs_component_desc_t for more details.
	*
	* @param world The world.
	* @param desc Component init parameters.
	* @return A handle to the new or existing component, or 0 if failed.
	*/
	ecs_component_init :: proc(world: ^ecs_world_t, desc: ^ecs_component_desc_t) -> ecs_entity_t ---

	/** Get the type info for a component.
	* This function returns the type information for a component. The component can
	* be a regular component or a pair. For the rules on how type information is
	* determined based on a component ID, see ecs_get_typeid().
	*
	* @param world The world.
	* @param component The component.
	* @return The type information of the component ID.
	*/
	ecs_get_type_info :: proc(world: ^ecs_world_t, component: ecs_id_t) -> ^ecs_type_info_t ---

	/** Register hooks for a component.
	* Hooks allow for the execution of user code when components are constructed,
	* copied, moved, destructed, added, removed, or set. Hooks can be assigned
	* as long as a component has not yet been used (added to an entity).
	*
	* The hooks that are currently set can be accessed with ecs_get_type_info().
	*
	* @param world The world.
	* @param component The component for which to register the actions.
	* @param hooks The type that contains the component actions.
	*/
	ecs_set_hooks_id :: proc(world: ^ecs_world_t, component: ecs_entity_t, hooks: ^ecs_type_hooks_t) ---

	/** Get hooks for a component.
	*
	* @param world The world.
	* @param component The component for which to retrieve the hooks.
	* @return The hooks for the component, or NULL if not registered.
	*/
	ecs_get_hooks_id :: proc(world: ^ecs_world_t, component: ecs_entity_t) -> ^ecs_type_hooks_t ---

	/** Return whether a specified component is a tag.
	* This operation returns whether the specified component is a tag (a component
	* without data or size).
	*
	* An ID is a tag when:
	* - it is an entity without the `EcsComponent` component
	* - it has an `EcsComponent` with size member set to 0
	* - it is a pair where both elements are a tag
	* - it is a pair where the first element has the #EcsPairIsTag tag
	*
	* @param world The world.
	* @param component The component.
	* @return Whether the provided ID is a tag.
	*/
	ecs_id_is_tag :: proc(world: ^ecs_world_t, component: ecs_id_t) -> bool ---

	/** Return whether a specified component is in use.
	* This operation returns whether a component is in use in the world. A
	* component is in use if it has been added to one or more tables.
	*
	* @param world The world.
	* @param component The component.
	* @return Whether the component is in use.
	*/
	ecs_id_in_use :: proc(world: ^ecs_world_t, component: ecs_id_t) -> bool ---

	/** Get the type for a component.
	* This operation returns the type for a component ID, if the ID is associated
	* with a type. For a regular component with a non-zero size (an entity with the
	* EcsComponent component), the operation will return the component ID itself.
	*
	* For an entity that does not have the EcsComponent component, or with an
	* EcsComponent value with size 0, the operation will return 0.
	*
	* For a pair ID, the operation will return the type associated with the pair, by
	* applying the following queries in order:
	* - The first pair element is returned if it is a component.
	* - 0 is returned if the relationship entity has the Tag property.
	* - The second pair element is returned if it is a component.
	* - 0 is returned.
	*
	* @param world The world.
	* @param component The component.
	* @return The type of the component.
	*/
	ecs_get_typeid :: proc(world: ^ecs_world_t, component: ecs_id_t) -> ecs_entity_t ---

	/** Utility to match a component with a pattern.
	* This operation returns true if the provided pattern matches the provided
	* component. The pattern may contain a wildcard (or wildcards, when a pair).
	*
	* @param component The component.
	* @param pattern The pattern to compare with.
	* @return Whether the ID matches the pattern.
	*/
	ecs_id_match :: proc(component: ecs_id_t, pattern: ecs_id_t) -> bool ---

	/** Utility to check if a component is a pair.
	*
	* @param component The component.
	* @return True if the component is a pair.
	*/
	ecs_id_is_pair :: proc(component: ecs_id_t) -> bool ---

	/** Utility to check if a component is a wildcard.
	*
	* @param component The component.
	* @return True if the component is a wildcard or a pair containing a wildcard.
	*/
	ecs_id_is_wildcard :: proc(component: ecs_id_t) -> bool ---

	/** Utility to check if a component is an any wildcard.
	*
	* @param component The component.
	* @return True if the component is an any wildcard or a pair containing an any wildcard.
	*/
	ecs_id_is_any :: proc(component: ecs_id_t) -> bool ---

	/** Utility to check if an ID is valid.
	* A valid ID is an ID that can be added to an entity. Invalid IDs are:
	* - IDs that contain wildcards
	* - IDs that contain invalid entities
	* - IDs that are 0 or contain 0 entities
	*
	* Note that the same rules apply to removing from an entity, with the exception
	* of wildcards.
	*
	* @param world The world.
	* @param component The component.
	* @return True if the ID is valid.
	*/
	ecs_id_is_valid :: proc(world: ^ecs_world_t, component: ecs_id_t) -> bool ---

	/** Get flags associated with an ID.
	* This operation returns the internal flags (see api_flags.h) that are
	* associated with the provided ID.
	*
	* @param world The world.
	* @param component The component.
	* @return The flags associated with the ID, or 0 if the ID is not in use.
	*/
	ecs_id_get_flags :: proc(world: ^ecs_world_t, component: ecs_id_t) -> ecs_flags32_t ---

	/** Convert a component flag to a string.
	* This operation converts a component flag to a string. Possible outputs are:
	*
	* - PAIR
	* - TOGGLE
	* - AUTO_OVERRIDE
	*
	* @param component_flags The component flag.
	* @return The ID flag string, or NULL if no valid ID is provided.
	*/
	ecs_id_flag_str :: proc(component_flags: u64) -> cstring ---

	/** Convert a component ID to a string.
	* This operation converts the provided component ID to a string. It can output
	* strings of the following formats:
	*
	* - "ComponentName"
	* - "FLAG|ComponentName"
	* - "(Relationship, Target)"
	* - "FLAG|(Relationship, Target)"
	*
	* The PAIR flag is never added to the string.
	*
	* @param world The world.
	* @param component The component to convert to a string.
	* @return The component converted to a string.
	*/
	ecs_id_str :: proc(world: ^ecs_world_t, component: ecs_id_t) -> cstring ---

	/** Write a component string to a buffer.
	* Same as ecs_id_str(), but writes the result to ecs_strbuf_t.
	*
	* @param world The world.
	* @param component The component to convert to a string.
	* @param buf The buffer to write to.
	*/
	ecs_id_str_buf :: proc(world: ^ecs_world_t, component: ecs_id_t, buf: ^ecs_strbuf_t) ---

	/** Convert a string to a component.
	* This operation is the reverse of ecs_id_str(). The FLECS_SCRIPT addon
	* is required for this operation to work.
	*
	* @param world The world.
	* @param expr The string to convert to an ID.
	* @return The ID, or 0 if the string could not be converted.
	*/
	ecs_id_from_str :: proc(world: ^ecs_world_t, expr: cstring) -> ecs_id_t ---

	/** Test whether a term ref is set.
	* A term ref is a reference to an entity, component, or variable for one of the
	* three parts of a term (src, first, second).
	*
	* @param ref The term ref.
	* @return True when set, false when not set.
	*/
	ecs_term_ref_is_set :: proc(ref: ^ecs_term_ref_t) -> bool ---

	/** Test whether a term is set.
	* This operation can be used to test whether a term has been initialized with
	* values or whether it is empty.
	*
	* An application generally does not need to invoke this operation. It is useful
	* when initializing a 0-initialized array of terms (like in ecs_query_desc_t), as
	* this operation can be used to find the last initialized element.
	*
	* @param term The term.
	* @return True when set, false when not set.
	*/
	ecs_term_is_initialized :: proc(term: ^ecs_term_t) -> bool ---

	/** Is a term matched on the $this variable.
	* This operation checks whether a term is matched on the $this variable, which
	* is the default source for queries.
	*
	* A term has a $this source when:
	* - ecs_term_t::src::id is EcsThis
	* - ecs_term_t::src::flags is EcsIsVariable
	*
	* If ecs_term_t::src is not populated, it will be automatically initialized to
	* the $this source for the created query.
	*
	* @param term The term.
	* @return True if the term matches $this, false if not.
	*/
	ecs_term_match_this :: proc(term: ^ecs_term_t) -> bool ---

	/** Is a term matched on a 0 source.
	* This operation checks whether a term is matched on a 0 source. A 0 source is
	* a term that isn't matched against anything, and can be used just to pass
	* (component) IDs to a query iterator.
	*
	* A term has a 0 source when:
	* - ecs_term_t::src::id is 0
	* - ecs_term_t::src::flags has EcsIsEntity set
	*
	* @param term The term.
	* @return True if the term has a 0 source, false if not.
	*/
	ecs_term_match_0 :: proc(term: ^ecs_term_t) -> bool ---

	/** Convert a term to a string expression.
	* Convert a term to a string expression. The resulting expression is equivalent
	* to the same term, with the exception of And and Or operators.
	*
	* @param world The world.
	* @param term The term.
	* @return The term converted to a string.
	*/
	ecs_term_str :: proc(world: ^ecs_world_t, term: ^ecs_term_t) -> cstring ---

	/** Convert a query to a string expression.
	* Convert a query to a string expression. The resulting expression can be
	* parsed to create the same query.
	*
	* @param query The query.
	* @return The query converted to a string.
	*/
	ecs_query_str :: proc(query: ^ecs_query_t) -> cstring ---

	/** Iterate all entities with a specified (component ID).
	* This returns an iterator that yields all entities with a single specified
	* component. This is a much lighter-weight operation than creating and
	* iterating a query.
	*
	* Usage:
	* @code
	* ecs_iter_t it = ecs_each(world, Player);
	* while (ecs_each_next(&it)) {
	*   for (int i = 0; i < it.count; i ++) {
	*     // Iterate as usual.
	*   }
	* }
	* @endcode
	*
	* If the specified ID is a component, it is possible to access the component
	* pointer with ecs_field() just like with regular queries:
	*
	* @code
	* ecs_iter_t it = ecs_each(world, Position);
	* while (ecs_each_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   for (int i = 0; i < it.count; i ++) {
	*     // Iterate as usual.
	*   }
	* }
	* @endcode
	*
	* @param world The world.
	* @param component The component to iterate.
	* @return An iterator that iterates all entities with the (component) ID.
	*/
	ecs_each_id :: proc(world: ^ecs_world_t, component: ecs_id_t) -> ecs_iter_t ---

	/** Progress an iterator created with ecs_each_id().
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*/
	ecs_each_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Iterate children of a parent.
	* This operation is usually equivalent to doing:
	* @code
	* ecs_iter_t it = ecs_each_id(world, ecs_pair(EcsChildOf, parent));
	* @endcode
	*
	* The only exception is when the parent has the EcsOrderedChildren trait, in
	* which case this operation will return a single result with the ordered
	* child entity IDs.
	*
	* This operation is equivalent to doing:
	*
	* @code
	* ecs_children_w_rel(world, EcsChildOf, parent);
	* @endcode
	*
	* @param world The world.
	* @param parent The parent.
	* @return An iterator that iterates all children of the parent.
	*
	* @see ecs_each_id()
	*/
	ecs_children :: proc(world: ^ecs_world_t, parent: ecs_entity_t) -> ecs_iter_t ---

	/** Same as ecs_children(), but with a custom relationship argument.
	*
	* @param world The world.
	* @param relationship The relationship.
	* @param parent The parent.
	* @return An iterator that iterates all children of the parent.
	*/
	ecs_children_w_rel :: proc(world: ^ecs_world_t, relationship: ecs_entity_t, parent: ecs_entity_t) -> ecs_iter_t ---

	/** Progress an iterator created with ecs_children().
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*/
	ecs_children_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Create a query.
	* If the descriptor specifies an existing entity, the entity must not already
	* be associated with a query. To replace an existing query on an entity, use
	* ecs_query_update().
	*
	* @param world The world.
	* @param desc The descriptor (see ecs_query_desc_t).
	* @return The query.
	*/
	ecs_query_init :: proc(world: ^ecs_world_t, desc: ^ecs_query_desc_t) -> ^ecs_query_t ---

	/** Replace the query on an existing entity.
	* Removes the query currently attached to the entity and creates a new one
	* from the descriptor. Any handles to the previous query become invalid; use
	* the returned handle for subsequent iteration.
	*
	* @param world The world.
	* @param entity The entity that holds the query to replace.
	* @param desc The descriptor (see ecs_query_desc_t).
	* @return The new query, or NULL if the operation failed.
	*/
	ecs_query_update :: proc(world: ^ecs_world_t, entity: ecs_entity_t, desc: ^ecs_query_desc_t) -> ^ecs_query_t ---

	/** Delete a query.
	*
	* @param query The query.
	*/
	ecs_query_fini :: proc(query: ^ecs_query_t) ---

	/** Find a variable index.
	* This operation looks up the index of a variable in the query. This index can
	* be used in operations like ecs_iter_set_var() and ecs_iter_get_var().
	*
	* @param query The query.
	* @param name The variable name.
	* @return The variable index.
	*/
	ecs_query_find_var :: proc(query: ^ecs_query_t, name: cstring) -> i32 ---

	/** Get the variable name.
	* This operation returns the variable name for an index.
	*
	* @param query The query.
	* @param var_id The variable index.
	* @return The variable name.
	*/
	ecs_query_var_name :: proc(query: ^ecs_query_t, var_id: i32) -> cstring ---

	/** Test if a variable is an entity.
	* Internally, the query engine has entity variables and table variables. When
	* iterating through query variables (by using ecs_query_t::var_count) only
	* the values for entity variables are accessible. This operation enables an
	* application to check if a variable is an entity variable.
	*
	* @param query The query.
	* @param var_id The variable ID.
	* @return Whether the variable is an entity variable.
	*/
	ecs_query_var_is_entity :: proc(query: ^ecs_query_t, var_id: i32) -> bool ---

	/** Create a query iterator.
	* Use an iterator to iterate through the entities that match a query. Queries
	* can return multiple results, and have to be iterated by repeatedly calling
	* ecs_query_next() until the operation returns false.
	*
	* Depending on the query, a single result can contain an entire table, a range
	* of entities in a table, or a single entity. Iteration code has an inner and
	* an outer loop. The outer loop loops through the query results, and typically
	* corresponds with a table. The inner loop iterates entities in the result.
	*
	* Example:
	* @code
	* ecs_iter_t it = ecs_query_iter(world, q);
	*
	* while (ecs_query_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   Velocity *v = ecs_field(&it, Velocity, 1);
	*
	*   for (int i = 0; i < it.count; i ++) {
	*     p[i].x += v[i].x;
	*     p[i].y += v[i].y;
	*   }
	* }
	* @endcode
	*
	* The world passed into the operation must be either the actual world or the
	* current stage, when iterating from a system. The stage is accessible through
	* the it.world member.
	*
	* Example:
	* @code
	* void MySystem(ecs_iter_t *it) {
	*   ecs_query_t *q = it->ctx; // Query passed as system context
	*
	*   // Create query iterator from system stage
	*   ecs_iter_t qit = ecs_query_iter(it->world, q);
	*   while (ecs_query_next(&qit)) {
	*     // Iterate as usual
	*   }
	* }
	* @endcode
	*
	* If query iteration is stopped without the last call to ecs_query_next()
	* returning false, iterator resources need to be cleaned up explicitly
	* with ecs_iter_fini().
	*
	* Example:
	* @code
	* ecs_iter_t it = ecs_query_iter(world, q);
	*
	* while (ecs_query_next(&it)) {
	*   if (!ecs_field_is_set(&it, 0)) {
	*     ecs_iter_fini(&it); // Free iterator resources
	*     break;
	*   }
	*
	*   for (int i = 0; i < it.count; i ++) {
	*     // ...
	*   }
	* }
	* @endcode
	*
	* @param world The world.
	* @param query The query.
	* @return An iterator.
	*
	* @see ecs_query_next()
	*/
	ecs_query_iter :: proc(world: ^ecs_world_t, query: ^ecs_query_t) -> ecs_iter_t ---

	/** Progress a query iterator.
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*
	* @see ecs_query_iter()
	*/
	ecs_query_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Match an entity with a query.
	* This operation matches an entity with a query and returns the result of the
	* match in the "it" out parameter. An application should free the iterator
	* resources with ecs_iter_fini() if this function returns true.
	*
	* Usage:
	* @code
	* ecs_iter_t it;
	* if (ecs_query_has(q, e, &it)) {
	*   ecs_iter_fini(&it);
	* }
	* @endcode
	*
	* @param query The query.
	* @param entity The entity to match.
	* @param it The iterator with matched data.
	* @return True if entity matches the query, false if not.
	*/
	ecs_query_has :: proc(query: ^ecs_query_t, entity: ecs_entity_t, it: ^ecs_iter_t) -> bool ---

	/** Match a table with a query.
	* This operation matches a table with a query and returns the result of the
	* match in the "it" out parameter. An application should free the iterator
	* resources with ecs_iter_fini() if this function returns true.
	*
	* Usage:
	* @code
	* ecs_iter_t it;
	* if (ecs_query_has_table(q, t, &it)) {
	*   ecs_iter_fini(&it);
	* }
	* @endcode
	*
	* @param query The query.
	* @param table The table to match.
	* @param it The iterator with matched data.
	* @return True if table matches the query, false if not.
	*/
	ecs_query_has_table :: proc(query: ^ecs_query_t, table: ^ecs_table_t, it: ^ecs_iter_t) -> bool ---

	/** Match a range with a query.
	* This operation matches a range with a query and returns the result of the
	* match in the "it" out parameter. An application should free the iterator
	* resources with ecs_iter_fini() if this function returns true.
	*
	* The entire range must match the query for the operation to return true.
	*
	* Usage:
	* @code
	* ecs_table_range_t range = {
	*   .table = table,
	*   .offset = 1,
	*   .count = 2
	* };
	*
	* ecs_iter_t it;
	* if (ecs_query_has_range(q, &range, &it)) {
	*   ecs_iter_fini(&it);
	* }
	* @endcode
	*
	* @param query The query.
	* @param range The range to match.
	* @param it The iterator with matched data.
	* @return True if range matches the query, false if not.
	*/
	ecs_query_has_range :: proc(query: ^ecs_query_t, range: ^ecs_table_range_t, it: ^ecs_iter_t) -> bool ---

	/** Return how often a match event happened for a cached query.
	* This operation can be used to determine whether the query cache has been
	* updated with new tables.
	*
	* @param query The query.
	* @return The number of match events that happened.
	*/
	ecs_query_match_count :: proc(query: ^ecs_query_t) -> i32 ---

	/** Convert a query to a string.
	* This will convert the query program to a string, which can aid in debugging
	* the behavior of a query.
	*
	* The returned string must be freed with ecs_os_free().
	*
	* @param query The query.
	* @return The query plan.
	*/
	ecs_query_plan :: proc(query: ^ecs_query_t) -> cstring ---

	/** Convert a query to a string with a profile.
	* To use this, you must set the EcsIterProfile flag on an iterator before
	* starting iteration:
	*
	* @code
	*   it.flags |= EcsIterProfile;
	* @endcode
	*
	* The returned string must be freed with ecs_os_free().
	*
	* @param query The query.
	* @param it The iterator with profile data.
	* @return The query plan with profile data.
	*/
	ecs_query_plan_w_profile :: proc(query: ^ecs_query_t, it: ^ecs_iter_t) -> cstring ---

	/** Same as ecs_query_plan(), but includes the plan for populating the cache (if any).
	*
	* @param query The query.
	* @return The query plan.
	*/
	ecs_query_plans :: proc(query: ^ecs_query_t) -> cstring ---

	/** Populate variables from a key-value string.
	* Convenience function to set query variables from a key-value string separated
	* by commas. The string must have the following format:
	*
	* @code
	*   var_a: value, var_b: value
	* @endcode
	*
	* The key-value list may optionally be enclosed in parentheses.
	*
	* This function uses the script addon.
	*
	* @param query The query.
	* @param it The iterator for which to set the variables.
	* @param expr The key-value expression.
	* @return A pointer to the next character after the last parsed one.
	*/
	ecs_query_args_parse :: proc(query: ^ecs_query_t, it: ^ecs_iter_t, expr: cstring) -> cstring ---

	/** Return whether the query data changed since the last iteration.
	* The operation will return true after:
	* - new entities have been matched
	* - new tables have been matched or unmatched
	* - matched entities were deleted
	* - matched components were changed
	*
	* The operation will not return true after a write-only (EcsOut) or filter
	* (EcsInOutFilter) term has changed, when a term is not matched with the
	* current table ($this source) or for tag terms.
	*
	* The changed state of a table is reset after it is iterated. If an iterator was
	* not iterated until completion, tables may still be marked as changed.
	*
	* To check the changed state of the current iterator result, use
	* ecs_iter_changed().
	*
	* @param query The query.
	* @return True if entities changed, otherwise false.
	*
	* @see ecs_iter_changed()
	*/
	ecs_query_changed :: proc(query: ^ecs_query_t) -> bool ---

	/** Get the query object.
	* Return the query object. Can be used to access various information about
	* the query.
	*
	* @param world The world.
	* @param query The query.
	* @return The query object.
	*/
	ecs_query_get :: proc(world: ^ecs_world_t, query: ecs_entity_t) -> ^ecs_query_t ---

	/** Skip a table while iterating.
	* This operation lets the query iterator know that a table was skipped while
	* iterating. A skipped table will not reset its changed state, and the query
	* will not update the dirty flags of the table for its out fields.
	*
	* Only valid iterators must be provided (next() has to be called at least once
	* and must return true), and the iterator must be a query iterator.
	*
	* @param it The iterator result to skip.
	*/
	ecs_iter_skip :: proc(it: ^ecs_iter_t) ---

	/** Set the group to iterate for a query iterator.
	* This operation limits the results returned by the query to only the selected
	* group ID. The query must have a group_by function, and the iterator must
	* be a query iterator.
	*
	* Groups are sets of tables that are stored together in the query cache based
	* on a group ID, which is calculated per table by the group_by function. To
	* iterate a group, an iterator only needs to know the first and last cache node
	* for that group, which can both be found in a fast O(1) operation.
	*
	* As a result, group iteration is one of the most efficient mechanisms to
	* filter out large numbers of entities, even if those entities are distributed
	* across many tables. This makes it a good fit for things like dividing up
	* a world into cells, and only iterating cells close to a player.
	*
	* The group to iterate must be set before the first call to ecs_query_next(). No
	* operations that can add or remove components should be invoked between calling
	* ecs_iter_set_group() and ecs_query_next().
	*
	* @param it The query iterator.
	* @param group_id The group to iterate.
	*/
	ecs_iter_set_group :: proc(it: ^ecs_iter_t, group_id: u64) ---

	/** Return the map with query groups.
	* This map can be used to iterate the active group identifiers of a query. The
	* payload of the map is opaque. The map can be used as follows:
	*
	* @code
	* const ecs_map_t *keys = ecs_query_get_groups(q);
	* ecs_map_iter_t kit = ecs_map_iter(keys);
	* while (ecs_map_next(&kit)) {
	*   uint64_t group_id = ecs_map_key(&kit);
	*
	*   // Iterate query for group
	*   ecs_iter_t it = ecs_query_iter(world, q);
	*   ecs_iter_set_group(&it, group_id);
	*   while (ecs_query_next(&it)) {
	*     // Iterate as usual
	*   }
	* }
	* @endcode
	*
	* This operation is not valid for queries that do not use group_by. The
	* returned map pointer will remain valid for as long as the query exists.
	*
	* @param query The query.
	* @return The map with query groups.
	*/
	ecs_query_get_groups :: proc(query: ^ecs_query_t) -> ^ecs_map_t ---

	/** Get the context of a query group.
	* This operation returns the context of a query group as returned by the
	* on_group_create callback.
	*
	* @param query The query.
	* @param group_id The group for which to obtain the context.
	* @return The group context, NULL if the group doesn't exist.
	*/
	ecs_query_get_group_ctx :: proc(query: ^ecs_query_t, group_id: u64) -> rawptr ---

	/** Get information about a query group.
	* This operation returns information about a query group, including the group
	* context returned by the on_group_create callback.
	*
	* @param query The query.
	* @param group_id The group for which to obtain the group info.
	* @return The group info, NULL if the group doesn't exist.
	*/
	ecs_query_get_group_info :: proc(query: ^ecs_query_t, group_id: u64) -> ^ecs_query_group_info_t ---
}

/** Struct returned by ecs_query_count(). */
ecs_query_count_t :: struct {
	results:  i32, /**< Number of results returned by the query. */
	entities: i32, /**< Number of entities returned by the query. */
	tables:   i32, /**< Number of tables returned by the query. Only set for
                             * queries for which the table count can be reliably
                             * determined. */
}

@(default_calling_convention="c")
foreign lib {
	/** Return the number of entities and results the query matches with.
	* Only entities matching the $this variable as source are counted.
	*
	* @param query The query.
	* @return The number of matched entities.
	*/
	ecs_query_count :: proc(query: ^ecs_query_t) -> ecs_query_count_t ---

	/** Test whether a query returns one or more results.
	*
	* @param query The query.
	* @return True if query matches anything, false if not.
	*/
	ecs_query_is_true :: proc(query: ^ecs_query_t) -> bool ---

	/** Get the query used to populate the cache.
	* This operation returns the query that is used to populate the query cache.
	* For queries that can be entirely cached, the returned query will be
	* equivalent to the query passed to ecs_query_init().
	*
	* @param query The query.
	* @return The query used to populate the cache, NULL if query is not cached.
	*/
	ecs_query_get_cache_query :: proc(query: ^ecs_query_t) -> ^ecs_query_t ---

	/** Send an event.
	* This sends an event to matching observers and is the mechanism used by Flecs
	* itself to send `OnAdd`, `OnRemove`, etc. events.
	*
	* Applications can use this function to send custom events, where a custom
	* event can be any regular entity.
	*
	* Applications should not send built-in Flecs events, as this may violate
	* assumptions the code makes about the conditions under which those events are
	* sent.
	*
	* Observers are invoked synchronously. It is therefore safe to use stack-based
	* data as event context, which can be set in the "param" member.
	*
	* @param world The world.
	* @param desc The event parameters.
	*
	* @see ecs_enqueue()
	*/
	ecs_emit :: proc(world: ^ecs_world_t, desc: ^ecs_event_desc_t) ---

	/** Enqueue an event.
	* Same as ecs_emit(), but enqueues an event in the command queue instead. The
	* event will be emitted when ecs_defer_end() is called.
	*
	* If this operation is called when the provided world is not in deferred mode,
	* it behaves just like ecs_emit().
	*
	* @param world The world.
	* @param desc The event parameters.
	*/
	ecs_enqueue :: proc(world: ^ecs_world_t, desc: ^ecs_event_desc_t) ---

	/** Create an observer.
	* Observers can subscribe for one or more terms. An observer only triggers
	* when the source of the event meets all terms.
	*
	* If the descriptor specifies an existing entity, the entity must not already
	* be associated with an observer. To modify an existing observer, use
	* ecs_observer_update().
	*
	* See the documentation for ecs_observer_desc_t for more details.
	*
	* @param world The world.
	* @param desc The observer creation parameters.
	* @return The observer, or 0 if the operation failed.
	*/
	ecs_observer_init :: proc(world: ^ecs_world_t, desc: ^ecs_observer_desc_t) -> ecs_entity_t ---

	/** Update an existing observer.
	* Updates the configuration of an observer that was previously created with
	* ecs_observer_init(). Only fields in desc that are set to a non-default
	* value will be applied; fields left at their default value preserve the
	* existing configuration of the observer.
	*
	* The query and events fields of the descriptor are not used by this function;
	* the observer query and event subscriptions cannot be modified after
	* creation.
	*
	* @param world The world.
	* @param observer The observer to update.
	* @param desc The observer descriptor.
	* @return The observer entity, or 0 if the operation failed.
	*/
	ecs_observer_update :: proc(world: ^ecs_world_t, observer: ecs_entity_t, desc: ^ecs_observer_desc_t) -> ecs_entity_t ---

	/** Get the observer object.
	* Return the observer object. Can be used to access various information about
	* the observer, like the query and context.
	*
	* @param world The world.
	* @param observer The observer.
	* @return The observer object.
	*/
	ecs_observer_get :: proc(world: ^ecs_world_t, observer: ecs_entity_t) -> ^ecs_observer_t ---

	/** Progress any iterator.
	* This operation is useful in combination with iterators for which it is not
	* known what created them. Example use cases are functions that should accept
	* any kind of iterator (such as serializers) or iterators created from poly
	* objects.
	*
	* This operation is slightly slower than using a type-specific iterator (e.g.,
	* ecs_query_next(), ecs_each_next()), as it has to call a function pointer, which
	* introduces a level of indirection.
	*
	* @param it The iterator.
	* @return True if iterator has more results, false if not.
	*/
	ecs_iter_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Clean up iterator resources.
	* This operation cleans up any resources associated with the iterator.
	*
	* This operation should only be used when an iterator is not iterated until
	* completion (next() has not yet returned false). When an iterator is iterated
	* until completion, resources are automatically freed.
	*
	* @param it The iterator.
	*/
	ecs_iter_fini :: proc(it: ^ecs_iter_t) ---

	/** Count the number of matched entities in a query.
	* This operation returns the number of matched entities. If a query contains no
	* matched entities but still yields results (e.g., it has no terms with $this
	* sources), the operation will return 0.
	*
	* To determine the number of matched entities, the operation iterates the
	* iterator until it yields no more results.
	*
	* @param it The iterator.
	* @return The number of matched entities.
	*/
	ecs_iter_count :: proc(it: ^ecs_iter_t) -> i32 ---

	/** Test if an iterator is true.
	* This operation will return true if the iterator returns at least one result.
	* This is especially useful in combination with fact-checking queries (see the
	* queries addon).
	*
	* The operation requires a valid iterator. After the operation is invoked, the
	* application should no longer invoke next() on the iterator and should treat it
	* as if the iterator is iterated until completion.
	*
	* @param it The iterator.
	* @return True if the iterator returns at least one result.
	*/
	ecs_iter_is_true :: proc(it: ^ecs_iter_t) -> bool ---

	/** Get the first matching entity from an iterator.
	* After this operation, the application should treat the iterator as if it has
	* been iterated until completion.
	*
	* @param it The iterator.
	* @return The first matching entity, or 0 if no entities were matched.
	*/
	ecs_iter_first :: proc(it: ^ecs_iter_t) -> ecs_entity_t ---

	/** Set the value for an iterator variable.
	* This constrains the iterator to return only results for which the variable
	* equals the specified value. The default value for all variables is
	* EcsWildcard, which means the variable can assume any value.
	*
	* Example:
	*
	* @code
	* // Query that matches (Eats, *)
	* ecs_query_t *q = ecs_query(world, {
	*   .terms = {
	*     { .first.id = Eats, .second.name = "$food" }
	*   }
	* });
	*
	* int food_var = ecs_query_find_var(q, "food");
	*
	* // Set Food to Apples, so we're only matching (Eats, Apples)
	* ecs_iter_t it = ecs_query_iter(world, q);
	* ecs_iter_set_var(&it, food_var, Apples);
	*
	* while (ecs_query_next(&it)) {
	*   for (int i = 0; i < it.count; i ++) {
	*     // iterate as usual
	*   }
	* }
	* @endcode
	*
	* The variable must be initialized after creating the iterator and before the
	* first call to next().
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @param entity The entity variable value.
	*
	* @see ecs_iter_set_var_as_range()
	* @see ecs_iter_set_var_as_table()
	*/
	ecs_iter_set_var :: proc(it: ^ecs_iter_t, var_id: i32, entity: ecs_entity_t) ---

	/** Same as ecs_iter_set_var(), but for a table.
	* This constrains the variable to all entities in a table.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @param table The table variable value.
	*
	* @see ecs_iter_set_var()
	* @see ecs_iter_set_var_as_range()
	*/
	ecs_iter_set_var_as_table :: proc(it: ^ecs_iter_t, var_id: i32, table: ^ecs_table_t) ---

	/** Same as ecs_iter_set_var(), but for a range of entities.
	* This constrains the variable to a range of entities in a table.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @param range The range variable value.
	*
	* @see ecs_iter_set_var()
	* @see ecs_iter_set_var_as_table()
	*/
	ecs_iter_set_var_as_range :: proc(it: ^ecs_iter_t, var_id: i32, range: ^ecs_table_range_t) ---

	/** Get the value of an iterator variable as an entity.
	* A variable can be interpreted as an entity if it is set to an entity, or if it
	* is set to a table range with count 1.
	*
	* This operation can only be invoked on valid iterators. The variable index
	* must be smaller than the total number of variables provided by the iterator
	* (as returned by ecs_iter_get_var_count()).
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable value.
	*/
	ecs_iter_get_var :: proc(it: ^ecs_iter_t, var_id: i32) -> ecs_entity_t ---

	/** Get the variable name.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable name.
	*/
	ecs_iter_get_var_name :: proc(it: ^ecs_iter_t, var_id: i32) -> cstring ---

	/** Get the number of variables.
	*
	* @param it The iterator.
	* @return The number of variables.
	*/
	ecs_iter_get_var_count :: proc(it: ^ecs_iter_t) -> i32 ---

	/** Get the variable array.
	*
	* @param it The iterator.
	* @return The variable array (if any).
	*/
	ecs_iter_get_vars :: proc(it: ^ecs_iter_t) -> ^ecs_var_t ---

	/** Get the value of an iterator variable as a table.
	* A variable can be interpreted as a table if it is set as a table range with
	* both offset and count set to 0, or if offset is 0 and count matches the
	* number of elements in the table.
	*
	* This operation can only be invoked on valid iterators. The variable index
	* must be smaller than the total number of variables provided by the iterator
	* (as returned by ecs_iter_get_var_count()).
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable value.
	*/
	ecs_iter_get_var_as_table :: proc(it: ^ecs_iter_t, var_id: i32) -> ^ecs_table_t ---

	/** Get the value of an iterator variable as a table range.
	* A value can be interpreted as a table range if it is set as a table range, or if
	* it is set to an entity with a non-empty type (the entity must have at least
	* one component, tag, or relationship in its type).
	*
	* This operation can only be invoked on valid iterators. The variable index
	* must be smaller than the total number of variables provided by the iterator
	* (as returned by ecs_iter_get_var_count()).
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return The variable value.
	*/
	ecs_iter_get_var_as_range :: proc(it: ^ecs_iter_t, var_id: i32) -> ecs_table_range_t ---

	/** Return whether a variable is constrained.
	* This operation returns true for variables set by one of the ecs_iter_set_var*
	* operations.
	*
	* A constrained variable is guaranteed not to change values while results are
	* being iterated.
	*
	* @param it The iterator.
	* @param var_id The variable index.
	* @return Whether the variable is constrained to a specified value.
	*/
	ecs_iter_var_is_constrained :: proc(it: ^ecs_iter_t, var_id: i32) -> bool ---

	/** Return the group ID for the currently iterated result.
	* This operation returns the group ID for queries that use group_by. If this
	* operation is called on an iterator that is not iterating a query that uses
	* group_by, it will fail.
	*
	* For queries that use cascade, this operation will return the hierarchy depth
	* of the currently iterated result.
	*
	* @param it The iterator.
	* @return The group ID of the currently iterated result.
	*/
	ecs_iter_get_group :: proc(it: ^ecs_iter_t) -> u64 ---

	/** Return whether the current iterator result has changed.
	* This operation must be used in combination with a query that supports change
	* detection (e.g., is cached). The operation returns whether the currently
	* iterated result has changed since the last time it was iterated by the query.
	*
	* Change detection works on a per-table basis. Changes to individual entities
	* cannot be detected this way.
	*
	* @param it The iterator.
	* @return True if the result changed, false if it didn't.
	*/
	ecs_iter_changed :: proc(it: ^ecs_iter_t) -> bool ---

	/** Convert an iterator to a string.
	* Prints the contents of an iterator to a string. Useful for debugging and/or
	* testing the output of an iterator.
	*
	* The function only converts the currently iterated data to a string. To
	* convert all data, the application has to manually call the next function and
	* call ecs_iter_str() on each result.
	*
	* @param it The iterator.
	* @return A string representing the contents of the iterator.
	*/
	ecs_iter_str :: proc(it: ^ecs_iter_t) -> cstring ---

	/** Create a paged iterator.
	* Paged iterators limit the results to those starting from 'offset', and will
	* return at most 'limit' results.
	*
	* The iterator must be iterated with ecs_page_next().
	*
	* A paged iterator acts as a passthrough for data exposed by the parent
	* iterator, so that any data provided by the parent will also be provided by
	* the paged iterator.
	*
	* @param it The source iterator.
	* @param offset The number of entities to skip.
	* @param limit The maximum number of entities to iterate.
	* @return A page iterator.
	*/
	ecs_page_iter :: proc(it: ^ecs_iter_t, offset: i32, limit: i32) -> ecs_iter_t ---

	/** Progress a paged iterator.
	* Progress an iterator created by ecs_page_iter().
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*/
	ecs_page_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Create a worker iterator.
	* Worker iterators can be used to equally divide the number of matched entities
	* across N resources (usually threads). Each resource will process the total
	* number of matched entities divided by 'count'.
	*
	* Entities are distributed across resources such that the distribution is
	* stable between queries. Two queries that match the same table are guaranteed
	* to match the same entities in that table.
	*
	* The iterator must be iterated with ecs_worker_next().
	*
	* A worker iterator acts as a passthrough for data exposed by the parent
	* iterator, so that any data provided by the parent will also be provided by
	* the worker iterator.
	*
	* @param it The source iterator.
	* @param index The index of the current resource.
	* @param count The total number of resources to divide entities between.
	* @return A worker iterator.
	*/
	ecs_worker_iter :: proc(it: ^ecs_iter_t, index: i32, count: i32) -> ecs_iter_t ---

	/** Progress a worker iterator.
	* Progress an iterator created by ecs_worker_iter().
	*
	* @param it The iterator.
	* @return True if the iterator has more results, false if not.
	*/
	ecs_worker_next :: proc(it: ^ecs_iter_t) -> bool ---

	/** Get data for a field.
	* This operation retrieves a pointer to an array of data that belongs to the
	* term in the query. The index refers to the location of the term in the query,
	* and starts counting from zero.
	*
	* For example, the query `"Position, Velocity"` will return the `Position` array
	* for index 0, and the `Velocity` array for index 1.
	*
	* When the specified field is not owned by the entity, this function returns a
	* pointer instead of an array. This happens when the source of a field is not
	* the entity being iterated, such as a shared component (from a prefab), a
	* component from a parent, or another entity. The ecs_field_is_self() operation
	* can be used to test dynamically if a field is owned.
	*
	* When a field contains a sparse component, use the ecs_field_at() function. When
	* a field is guaranteed to be set and owned, the ecs_field_self() function can be
	* used. ecs_field_self() has slightly better performance, and provides stricter
	* validity checking.
	*
	* The provided size must be either 0 or must match the size of the type
	* of the returned array. If the size does not match, the operation may assert.
	* The size can be dynamically obtained with ecs_field_size().
	*
	* An example:
	*
	* @code
	* while (ecs_query_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   Velocity *v = ecs_field(&it, Velocity, 1);
	*   for (int32_t i = 0; i < it.count; i ++) {
	*     p[i].x += v[i].x;
	*     p[i].y += v[i].y;
	*   }
	* }
	* @endcode
	*
	* @param it The iterator.
	* @param size The size of the field type.
	* @param index The index of the field.
	* @return A pointer to the data of the field.
	*/
	ecs_field_w_size :: proc(it: ^ecs_iter_t, size: c.size_t, index: i8) -> rawptr ---

	/** Get data for a field at a specified row.
	* This operation should be used instead of ecs_field_w_size() for sparse
	* component fields. This operation should be called for each returned row in a
	* result. In the following example, the Velocity component is sparse:
	*
	* @code
	* while (ecs_query_next(&it)) {
	*   Position *p = ecs_field(&it, Position, 0);
	*   for (int32_t i = 0; i < it.count; i ++) {
	*     Velocity *v = ecs_field_at(&it, Velocity, 1, i);
	*     p[i].x += v->x;
	*     p[i].y += v->y;
	*   }
	* }
	* @endcode
	*
	* @param it The iterator.
	* @param size The size of the field type.
	* @param index The index of the field.
	* @param row The row to get data for.
	* @return A pointer to the data of the field.
	*/
	ecs_field_at_w_size :: proc(it: ^ecs_iter_t, size: c.size_t, index: i8, row: i32) -> rawptr ---

	/** Test whether the field is read-only.
	* This operation returns whether the field is read-only. Read-only fields are
	* annotated with [in], or are added as a const type in the C++ API.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is read-only.
	*/
	ecs_field_is_readonly :: proc(it: ^ecs_iter_t, index: i8) -> bool ---

	/** Test whether the field is write-only.
	* This operation returns whether this is a write-only field. Write-only terms are
	* annotated with [out].
	*
	* Serializers are not required to serialize the values of a write-only field.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is write-only.
	*/
	ecs_field_is_writeonly :: proc(it: ^ecs_iter_t, index: i8) -> bool ---

	/** Test whether a field is set.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is set.
	*/
	ecs_field_is_set :: proc(it: ^ecs_iter_t, index: i8) -> bool ---

	/** Return the ID matched for a field.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The ID matched for the field.
	*/
	ecs_field_id :: proc(it: ^ecs_iter_t, index: i8) -> ecs_id_t ---

	/** Return the index of a matched table column.
	* This function only returns column indices for fields that have been matched
	* on the $this variable. Fields matched on other tables will return -1.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The index of the matched column, -1 if not matched.
	*/
	ecs_field_column :: proc(it: ^ecs_iter_t, index: i8) -> i32 ---

	/** Return the field source.
	* The field source is the entity on which the field was matched.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The source for the field.
	*/
	ecs_field_src :: proc(it: ^ecs_iter_t, index: i8) -> ecs_entity_t ---

	/** Return the field type size.
	* Returns the type size of the field. Returns 0 if the field has no data.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return The type size for the field.
	*/
	ecs_field_size :: proc(it: ^ecs_iter_t, index: i8) -> c.size_t ---

	/** Test whether the field is matched on self.
	* This operation returns whether the field is matched on the currently iterated
	* entity. This function will return false when the field is owned by another
	* entity, such as a parent or a prefab.
	*
	* When this operation returns false, the field must be accessed as a single
	* value instead of an array. Fields for which this operation returns true
	* return arrays with it->count values.
	*
	* @param it The iterator.
	* @param index The index of the field in the iterator.
	* @return Whether the field is matched on self.
	*/
	ecs_field_is_self :: proc(it: ^ecs_iter_t, index: i8) -> bool ---

	/** Get the type for a table.
	* The table type is a vector that contains all component, tag, and pair IDs.
	*
	* @param table The table.
	* @return The type of the table.
	*/
	ecs_table_get_type :: proc(table: ^ecs_table_t) -> ^ecs_type_t ---

	/** Get the type index for a component.
	* This operation returns the index for a component in the table's type.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component.
	* @return The index of the component in the table type, or -1 if not found.
	*
	* @see ecs_table_has_id()
	*/
	ecs_table_get_type_index :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t) -> i32 ---

	/** Get the column index for a component.
	* This operation returns the column index for a component in the table's type.
	* If the component doesn't have data (it is a tag), the function will return -1.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component.
	* @return The column index of the component ID, or -1 if not found or not a component.
	*/
	ecs_table_get_column_index :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t) -> i32 ---

	/** Return the number of columns in a table.
	* Similar to `ecs_table_get_type(table)->count`, except that the column count
	* only counts the number of components in a table.
	*
	* @param table The table.
	* @return The number of columns in the table.
	*/
	ecs_table_column_count :: proc(table: ^ecs_table_t) -> i32 ---

	/** Convert a type index to a column index.
	* Tables have an array of columns for each component in the table. This array
	* does not include elements for tags, which means that the index for a
	* component in the table type is not necessarily the same as the index in the
	* column array. This operation converts from an index in the table type to an
	* index in the column array.
	*
	* @param table The table.
	* @param index The index in the table type.
	* @return The index in the table column array.
	*
	* @see ecs_table_column_to_type_index()
	*/
	ecs_table_type_to_column_index :: proc(table: ^ecs_table_t, index: i32) -> i32 ---

	/** Convert a column index to a type index.
	* Same as ecs_table_type_to_column_index(), but converts from an index in the
	* column array to an index in the table type.
	*
	* @param table The table.
	* @param index The column index.
	* @return The index in the table type.
	*/
	ecs_table_column_to_type_index :: proc(table: ^ecs_table_t, index: i32) -> i32 ---

	/** Get a column from a table by column index.
	* This operation returns the component array for the provided index.
	*
	* @param table The table.
	* @param index The column index.
	* @param offset The index of the first row to return (0 for entire column).
	* @return The component array, or NULL if the index is not a component.
	*/
	ecs_table_get_column :: proc(table: ^ecs_table_t, index: i32, offset: i32) -> rawptr ---

	/** Get a column from a table by component.
	* This operation returns the component array for the provided component.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component for the column.
	* @param offset The index of the first row to return (0 for entire column).
	* @return The component array, or NULL if the component is not found.
	*/
	ecs_table_get_id :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t, offset: i32) -> rawptr ---

	/** Get the column size from a table.
	* This operation returns the component size for the provided index.
	*
	* @param table The table.
	* @param index The column index.
	* @return The component size, or 0 if the index is not a component.
	*/
	ecs_table_get_column_size :: proc(table: ^ecs_table_t, index: i32) -> c.size_t ---

	/** Return the number of entities in the table.
	* This operation returns the number of entities in the table.
	*
	* @param table The table.
	* @return The number of entities in the table.
	*/
	ecs_table_count :: proc(table: ^ecs_table_t) -> i32 ---

	/** Return the allocated size of the table.
	* This operation returns the number of elements allocated in the table
	* per column.
	*
	* @param table The table.
	* @return The number of allocated elements in the table.
	*/
	ecs_table_size :: proc(table: ^ecs_table_t) -> i32 ---

	/** Return the array with entity IDs for the table.
	* The size of the returned array is the result of ecs_table_count().
	*
	* @param table The table.
	* @return The array with entity IDs for the table.
	*/
	ecs_table_entities :: proc(table: ^ecs_table_t) -> ^ecs_entity_t ---

	/** Test if a table has a component.
	* Same as `ecs_table_get_type_index(world, table, component) != -1`.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component.
	* @return True if the table has the component ID, false if the table doesn't.
	*
	* @see ecs_table_get_type_index()
	*/
	ecs_table_has_id :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t) -> bool ---

	/** Get the relationship target for a table.
	*
	* @param world The world.
	* @param table The table.
	* @param relationship The relationship for which to obtain the target.
	* @param index The index, in case the table has multiple instances of the relationship.
	* @return The requested relationship target.
	*
	* @see ecs_get_target()
	*/
	ecs_table_get_target :: proc(world: ^ecs_world_t, table: ^ecs_table_t, relationship: ecs_entity_t, index: i32) -> ecs_entity_t ---

	/** Return the depth for a table in the tree for the specified relationship.
	* Depth is determined by counting the number of targets encountered while
	* traversing up the relationship tree. Only acyclic relationships are
	* supported.
	*
	* @param world The world.
	* @param table The table.
	* @param rel The relationship.
	* @return The depth of the table in the tree.
	*/
	ecs_table_get_depth :: proc(world: ^ecs_world_t, table: ^ecs_table_t, rel: ecs_entity_t) -> i32 ---

	/** Get the table that has all components of the current table plus the specified ID.
	* If the provided table already has the provided ID, the operation will return
	* the provided table.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component to add.
	* @return The resulting table.
	*/
	ecs_table_add_id :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t) -> ^ecs_table_t ---

	/** Find a table from an ID array.
	* This operation finds or creates a table with the specified array of
	* (component) IDs. The IDs in the array must be sorted, and it may not contain
	* duplicate elements.
	*
	* @param world The world.
	* @param ids The ID array.
	* @param id_count The number of elements in the ID array.
	* @return The table with the specified (component) IDs.
	*/
	ecs_table_find :: proc(world: ^ecs_world_t, ids: ^ecs_id_t, id_count: i32) -> ^ecs_table_t ---

	/** Get the table that has all components of the current table minus the specified component.
	* If the provided table doesn't have the provided component, the operation will
	* return the provided table.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component to remove.
	* @return The resulting table.
	*/
	ecs_table_remove_id :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t) -> ^ecs_table_t ---

	/** Lock a table.
	* When a table is locked, modifications to it will throw an assert. When the
	* table is locked recursively, it will take an equal amount of unlock
	* operations to actually unlock the table.
	*
	* Table locks can be used to build safe iterators where it is guaranteed that
	* the contents of a table are not modified while it is being iterated.
	*
	* The operation only works when called on the world, and has no side effects
	* when called on a stage. The assumption is that when called on a stage,
	* operations are deferred already.
	*
	* @param world The world.
	* @param table The table to lock.
	*/
	ecs_table_lock :: proc(world: ^ecs_world_t, table: ^ecs_table_t) ---

	/** Unlock a table.
	* Must be called after calling ecs_table_lock().
	*
	* @param world The world.
	* @param table The table to unlock.
	*/
	ecs_table_unlock :: proc(world: ^ecs_world_t, table: ^ecs_table_t) ---

	/** Test a table for flags.
	* Test if a table has all of the provided flags. See
	* include/flecs/private/api_flags.h for a list of table flags that can be used
	* with this function.
	*
	* @param table The table.
	* @param flags The flags to test for.
	* @return Whether the specified flags are set for the table.
	*/
	ecs_table_has_flags :: proc(table: ^ecs_table_t, flags: ecs_flags32_t) -> bool ---

	/** Check if a table has traversable entities.
	* Traversable entities are entities that are used as a target in a pair with a
	* relationship that has the Traversable trait.
	*
	* @param table The table.
	* @return Whether the table has traversable entities.
	*/
	ecs_table_has_traversable :: proc(table: ^ecs_table_t) -> bool ---

	/** Swap two elements inside the table.
	* This is useful for implementing custom
	* table sorting algorithms.
	*
	* @param world The world.
	* @param table The table to swap elements in.
	* @param row_1 The table element to swap with row_2.
	* @param row_2 The table element to swap with row_1.
	*/
	ecs_table_swap_rows :: proc(world: ^ecs_world_t, table: ^ecs_table_t, row_1: i32, row_2: i32) ---

	/** Commit (move) an entity to a table.
	* This operation moves an entity from its current table to the specified
	* table. This may cause the following actions:
	* - Ctor for each component in the target table.
	* - Move for each overlapping component.
	* - Dtor for each component in the source table.
	* - `OnAdd` observers for non-overlapping components in the target table.
	* - `OnRemove` observers for non-overlapping components in the source table.
	*
	* This operation is faster than adding or removing components individually.
	*
	* The application must explicitly provide the difference in components between
	* tables as the added and removed parameters. This can usually be derived directly
	* from the result of ecs_table_add_id() and ecs_table_remove_id(). These arrays are
	* required to properly execute `OnAdd` and `OnRemove` observers.
	*
	* @param world The world.
	* @param entity The entity to commit.
	* @param record The entity's record (optional, providing it saves a lookup).
	* @param table The table to commit the entity to.
	* @param added The components added to the entity.
	* @param removed The components removed from the entity.
	* @return True if the entity got moved, false otherwise.
	*/
	ecs_commit :: proc(world: ^ecs_world_t, entity: ecs_entity_t, record: ^ecs_record_t, table: ^ecs_table_t, added: ^ecs_type_t, removed: ^ecs_type_t) -> bool ---

	/** Search for a component in a table type.
	* This operation returns the index of the first occurrence of the component in the
	* table type. The component may be a pair or a wildcard.
	*
	* When component_out is provided, the function will assign it with the found
	* component. The found component may be different from the provided component
	* if it is a wildcard.
	*
	* This is a constant-time operation.
	*
	* @param world The world.
	* @param table The table.
	* @param component The component to search for.
	* @param component_out If provided, it will be set to the found component (optional).
	* @return The index of the ID in the table type.
	*
	* @see ecs_search_offset()
	* @see ecs_search_relation()
	*/
	ecs_search :: proc(world: ^ecs_world_t, table: ^ecs_table_t, component: ecs_id_t, component_out: ^ecs_id_t) -> i32 ---

	/** Search for a component in a table type starting from an offset.
	* This operation is the same as ecs_search(), but starts searching from an offset
	* in the table type.
	*
	* This operation is typically called in a loop where the resulting index is
	* used in the next iteration as offset:
	*
	* @code
	* int32_t index = -1;
	* while ((index = ecs_search_offset(world, table, index + 1, id, NULL)) != -1) {
	*   // do stuff
	* }
	* @endcode
	*
	* Depending on how the operation is used, it is either linear or constant time.
	* When the ID has the form `(id)` or `(rel, *)` and the operation is invoked as
	* in the above example, it is guaranteed to be constant time.
	*
	* If the provided component has the form `(*, tgt)`, the operation takes linear
	* time. The reason for this is that IDs for a target are not packed together,
	* as they are sorted relationship-first.
	*
	* If the component at the offset does not match the provided ID, the operation
	* will do a linear search to find a matching ID.
	*
	* @param world The world.
	* @param table The table.
	* @param offset The offset from where to start searching.
	* @param component The component to search for.
	* @param component_out If provided, it will be set to the found component (optional).
	* @return The index of the ID in the table type.
	*
	* @see ecs_search()
	* @see ecs_search_relation()
	*/
	ecs_search_offset :: proc(world: ^ecs_world_t, table: ^ecs_table_t, offset: i32, component: ecs_id_t, component_out: ^ecs_id_t) -> i32 ---

	/** Search for a component or relationship ID in a table type starting from an offset.
	* This operation is the same as ecs_search_offset(), but has the additional
	* capability of traversing relationships to find a component. For example, if
	* an application wants to find a component for either the provided table or a
	* prefab (using the `IsA` relationship) of that table, it could use the operation
	* like this:
	*
	* @code
	* int32_t index = ecs_search_relation(
	*   world,            // the world
	*   table,            // the table
	*   0,                // offset 0
	*   ecs_id(Position), // the component ID
	*   EcsIsA,           // the relationship to traverse
	*   EcsSelf|EcsUp,    // search self and up
	*   NULL,             // (optional) entity on which component was found
	*   NULL,             // (optional) found component ID
	*   NULL);            // internal type with information about matched ID
	* @endcode
	*
	* The operation searches depth-first. If a table type has 2 `IsA` relationships, the
	* operation will first search the `IsA` tree of the first relationship.
	*
	* When choosing between ecs_search(), ecs_search_offset(), and ecs_search_relation(),
	* the simpler the function, the better its performance.
	*
	* @param world The world.
	* @param table The table.
	* @param offset The offset from where to start searching.
	* @param component The component to search for.
	* @param rel The relationship to traverse (optional).
	* @param flags Whether to search EcsSelf and/or EcsUp.
	* @param tgt_out If provided, it will be set to the matched entity.
	* @param component_out If provided, it will be set to the found component (optional).
	* @param tr_out The internal datatype.
	* @return The index of the component in the table type.
	*
	* @see ecs_search()
	* @see ecs_search_offset()
	*/
	ecs_search_relation :: proc(world: ^ecs_world_t, table: ^ecs_table_t, offset: i32, component: ecs_id_t, rel: ecs_entity_t, flags: ecs_flags64_t, tgt_out: ^ecs_entity_t, component_out: ^ecs_id_t, tr_out: ^^ecs_table_record_t) -> i32 ---

	/** Search for a component ID by following a relationship, starting from an entity.
	* This operation is the same as ecs_search_relation(), but starts the search
	* from an entity rather than a table.
	*
	* @param world The world.
	* @param entity The entity from which to begin the search.
	* @param id The component ID to search for.
	* @param rel The relationship to follow.
	* @param self If true, also search components on the entity itself.
	* @param cr Optional component record for the component ID.
	* @param tgt_out Out parameter for the target entity.
	* @param id_out Out parameter for the found component ID.
	* @param tr_out Out parameter for the table record.
	* @return The index of the component ID in the entity's type, or -1 if not found.
	*/
	ecs_search_relation_for_entity :: proc(world: ^ecs_world_t, entity: ecs_entity_t, id: ecs_id_t, rel: ecs_entity_t, self: bool, cr: ^ecs_component_record_t, tgt_out: ^ecs_entity_t, id_out: ^ecs_id_t, tr_out: ^^ecs_table_record_t) -> i32 ---

	/** Remove all entities in a table. Does not deallocate table memory.
	* Retaining table memory can be efficient when planning
	* to refill the table with operations like ecs_bulk_init().
	*
	* @param world The world.
	* @param table The table to clear.
	*/
	ecs_table_clear_entities :: proc(world: ^ecs_world_t, table: ^ecs_table_t) ---

	/** Construct a value in existing storage.
	*
	* @param world The world.
	* @param type The type of the value to create.
	* @param ptr A pointer to a value of type 'type'.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_init :: proc(world: ^ecs_world_t, type: ecs_entity_t, ptr: rawptr) -> i32 ---

	/** Construct a value in existing storage.
	*
	* @param world The world.
	* @param ti The type info of the type to create.
	* @param ptr A pointer to a value of type 'type'.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_init_w_type_info :: proc(world: ^ecs_world_t, ti: ^ecs_type_info_t, ptr: rawptr) -> i32 ---

	/** Construct a value in new storage.
	*
	* @param world The world.
	* @param type The type of the value to create.
	* @return A pointer to the value if successful, NULL if failed.
	*/
	ecs_value_new :: proc(world: ^ecs_world_t, type: ecs_entity_t) -> rawptr ---

	/** Construct a value in new storage.
	*
	* @param world The world.
	* @param ti The type info of the type to create.
	* @return A pointer to the value if successful, NULL if failed.
	*/
	ecs_value_new_w_type_info :: proc(world: ^ecs_world_t, ti: ^ecs_type_info_t) -> rawptr ---

	/** Destruct a value.
	*
	* @param world The world.
	* @param ti The type info of the value to destruct.
	* @param ptr A pointer to a constructed value of type 'type'.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_fini_w_type_info :: proc(world: ^ecs_world_t, ti: ^ecs_type_info_t, ptr: rawptr) -> i32 ---

	/** Destruct a value.
	*
	* @param world The world.
	* @param type The type of the value to destruct.
	* @param ptr A pointer to a constructed value of type 'type'.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_fini :: proc(world: ^ecs_world_t, type: ecs_entity_t, ptr: rawptr) -> i32 ---

	/** Destruct a value and free storage.
	*
	* @param world The world.
	* @param type The type of the value to destruct.
	* @param ptr A pointer to the value.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_free :: proc(world: ^ecs_world_t, type: ecs_entity_t, ptr: rawptr) -> i32 ---

	/** Copy a value.
	*
	* @param world The world.
	* @param ti The type info of the value to copy.
	* @param dst A pointer to the storage to copy to.
	* @param src A pointer to the value to copy.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_copy_w_type_info :: proc(world: ^ecs_world_t, ti: ^ecs_type_info_t, dst: rawptr, src: rawptr) -> i32 ---

	/** Copy a value.
	*
	* @param world The world.
	* @param type The type of the value to copy.
	* @param dst A pointer to the storage to copy to.
	* @param src A pointer to the value to copy.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_copy :: proc(world: ^ecs_world_t, type: ecs_entity_t, dst: rawptr, src: rawptr) -> i32 ---

	/** Move a value.
	*
	* @param world The world.
	* @param ti The type info of the value to move.
	* @param dst A pointer to the storage to move to.
	* @param src A pointer to the value to move.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_move_w_type_info :: proc(world: ^ecs_world_t, ti: ^ecs_type_info_t, dst: rawptr, src: rawptr) -> i32 ---

	/** Move a value.
	*
	* @param world The world.
	* @param type The type of the value to move.
	* @param dst A pointer to the storage to move to.
	* @param src A pointer to the value to move.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_move :: proc(world: ^ecs_world_t, type: ecs_entity_t, dst: rawptr, src: rawptr) -> i32 ---

	/** Move-construct a value.
	*
	* @param world The world.
	* @param ti The type info of the value to move.
	* @param dst A pointer to the storage to move to.
	* @param src A pointer to the value to move.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_move_ctor_w_type_info :: proc(world: ^ecs_world_t, ti: ^ecs_type_info_t, dst: rawptr, src: rawptr) -> i32 ---

	/** Move-construct a value.
	*
	* @param world The world.
	* @param type The type of the value to move.
	* @param dst A pointer to the storage to move to.
	* @param src A pointer to the value to move.
	* @return Zero if successful, nonzero if failed.
	*/
	ecs_value_move_ctor :: proc(world: ^ecs_world_t, type: ecs_entity_t, dst: rawptr, src: rawptr) -> i32 ---

	/** Log message indicating an operation is deprecated.
	*
	* @param file The source file.
	* @param line The source line.
	* @param msg The deprecation message.
	*/
	ecs_deprecated_ :: proc(file: cstring, line: i32, msg: cstring) ---

	/** Increase log stack.
	* This operation increases the indent_ value of the OS API and can be useful to
	* make nested behavior more visible.
	*
	* @param level The log level.
	*/
	ecs_log_push_ :: proc(level: i32) ---

	/** Decrease log stack.
	* This operation decreases the indent_ value of the OS API and can be useful to
	* make nested behavior more visible.
	*
	* @param level The log level.
	*/
	ecs_log_pop_ :: proc(level: i32) ---

	/** Should current level be logged.
	* This operation returns true when the specified log level should be logged
	* with the current log level.
	*
	* @param level The log level to check for.
	* @return Whether logging is enabled for the current level.
	*/
	ecs_should_log :: proc(level: i32) -> bool ---

	/** Get description for error code.
	*
	* @param error_code The error code.
	* @return String describing the error code.
	*/
	ecs_strerror :: proc(error_code: i32) -> cstring ---

	/** Print at the provided log level.
	*
	* @param level The log level.
	* @param file The source file.
	* @param line The source line.
	* @param fmt The format string.
	*/
	ecs_print_ :: proc(level: i32, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---

	/** Print at the provided log level (va_list).
	*
	* @param level The log level.
	* @param file The source file.
	* @param line The source line.
	* @param fmt The format string.
	* @param args The format argument list.
	*/
	ecs_printv_ :: proc(level: i32, file: cstring, line: i32, fmt: cstring, args: c.va_list) ---

	/** Log at the provided level.
	*
	* @param level The log level.
	* @param file The source file.
	* @param line The source line.
	* @param fmt The format string.
	*/
	ecs_log_ :: proc(level: i32, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---

	/** Log at the provided level (va_list).
	*
	* @param level The log level.
	* @param file The source file.
	* @param line The source line.
	* @param fmt The format string.
	* @param args The format argument list.
	*/
	ecs_logv_ :: proc(level: i32, file: cstring, line: i32, fmt: cstring, args: c.va_list) ---

	/** Abort with error code.
	*
	* @param error_code The error code.
	* @param file The source file.
	* @param line The source line.
	* @param fmt The format string.
	*/
	ecs_abort_ :: proc(error_code: i32, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---

	/** Log an assertion failure.
	*
	* @param error_code The error code.
	* @param condition_str The condition that was not met.
	* @param file The source file.
	* @param line The source line.
	* @param fmt The format string.
	*/
	ecs_assert_log_ :: proc(error_code: i32, condition_str: cstring, file: cstring, line: i32, fmt: cstring, #c_vararg _: ..any) ---

	/** Log a parser error.
	*
	* @param name The name of the expression.
	* @param expr The expression string.
	* @param column The column at which the error occurred.
	* @param fmt The format string.
	*/
	ecs_parser_error_ :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, #c_vararg _: ..any) ---

	/** Log a parser error (va_list).
	*
	* @param name The name of the expression.
	* @param expr The expression string.
	* @param column The column at which the error occurred.
	* @param fmt The format string.
	* @param args The format argument list.
	*/
	ecs_parser_errorv_ :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, args: c.va_list) ---

	/** Log a parser warning.
	*
	* @param name The name of the expression.
	* @param expr The expression string.
	* @param column The column at which the error occurred.
	* @param fmt The format string.
	*/
	ecs_parser_warning_ :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, #c_vararg _: ..any) ---

	/** Log a parser warning (va_list).
	*
	* @param name The name of the expression.
	* @param expr The expression string.
	* @param column The column at which the error occurred.
	* @param fmt The format string.
	* @param args The format argument list.
	*/
	ecs_parser_warningv_ :: proc(name: cstring, expr: cstring, column: i64, fmt: cstring, args: c.va_list) ---

	/** Enable or disable log.
	* This will enable the built-in log. For log to work, it will have to be
	* compiled in, which requires defining one of the following macros:
	*
	* FLECS_LOG_0 - All log is disabled
	* FLECS_LOG_1 - Enable log level 1
	* FLECS_LOG_2 - Enable log level 2 and below
	* FLECS_LOG_3 - Enable log level 3 and below
	*
	* If no log level is defined and this is a debug build, FLECS_LOG_3 will
	* have been automatically defined.
	*
	* The provided level corresponds with the log level. If -1 is provided as
	* value, warnings are disabled. If -2 is provided, errors are disabled as well.
	*
	* @param level Desired tracing level.
	* @return Previous log level.
	*/
	ecs_log_set_level :: proc(level: i32) -> i32 ---

	/** Get current log level.
	*
	* @return Current log level.
	*/
	ecs_log_get_level :: proc() -> i32 ---

	/** Enable/disable tracing with colors.
	* By default, colors are enabled.
	*
	* @param enabled Whether to enable tracing with colors.
	* @return Previous color setting.
	*/
	ecs_log_enable_colors :: proc(enabled: bool) -> bool ---

	/** Enable/disable logging timestamp.
	* By default, timestamps are disabled. Note that enabling timestamps introduces
	* overhead as the logging code will need to obtain the current time.
	*
	* @param enabled Whether to enable tracing with timestamps.
	* @return Previous timestamp setting.
	*/
	ecs_log_enable_timestamp :: proc(enabled: bool) -> bool ---

	/** Enable/disable logging time since last log.
	* By default, deltatime is disabled. Note that enabling timestamps introduces
	* overhead as the logging code will need to obtain the current time.
	*
	* When enabled, this logs the amount of time in seconds passed since the last
	* log, when this amount is non-zero. The format is a '+' character followed by
	* the number of seconds:
	*
	*     +1 trace: log message
	*
	* @param enabled Whether to enable tracing with timestamps.
	* @return Previous timestamp setting.
	*/
	ecs_log_enable_timedelta :: proc(enabled: bool) -> bool ---

	/** Get last logged error code.
	* Calling this operation resets the error code.
	*
	* @return Last error, 0 if none was logged since last call to last_error.
	*/
	ecs_log_last_error :: proc() -> i32 ---

	/** Start capturing log output.
	*
	* @param capture_try If true, also capture messages from ecs_log_try blocks.
	*/
	ecs_log_start_capture :: proc(capture_try: bool) ---

	/** Stop capturing log output.
	*
	* @return The captured log output, or NULL if no output was captured.
	*/
	ecs_log_stop_capture :: proc() -> cstring ---
}

////////////////////////////////////////////////////////////////////////////////
//// Error codes
////////////////////////////////////////////////////////////////////////////////

/** Invalid operation error code. */
ECS_INVALID_OPERATION :: (1)

/** Invalid parameter error code. */
ECS_INVALID_PARAMETER :: (2)

/** Constraint violated error code. */
ECS_CONSTRAINT_VIOLATED :: (3)

/** Out of memory error code. */
ECS_OUT_OF_MEMORY :: (4)

/** Out of range error code. */
ECS_OUT_OF_RANGE :: (5)

/** Unsupported error code. */
ECS_UNSUPPORTED :: (6)

/** Internal error code. */
ECS_INTERNAL_ERROR :: (7)

/** Already defined error code. */
ECS_ALREADY_DEFINED :: (8)

/** Missing OS API error code. */
ECS_MISSING_OS_API :: (9)

/** Operation failed error code. */
ECS_OPERATION_FAILED :: (10)

/** Invalid conversion error code. */
ECS_INVALID_CONVERSION :: (11)

/** Cycle detected error code. */
ECS_CYCLE_DETECTED :: (13)

/** Leak detected error code. */
ECS_LEAK_DETECTED :: (14)

/** Double free error code. */
ECS_DOUBLE_FREE :: (15)

/** Inconsistent name error code. */
ECS_INCONSISTENT_NAME :: (20)

/** Name in use error code. */
ECS_NAME_IN_USE :: (21)

/** Invalid component size error code. */
ECS_INVALID_COMPONENT_SIZE :: (23)

/** Invalid component alignment error code. */
ECS_INVALID_COMPONENT_ALIGNMENT :: (24)

/** Component not registered error code. */
ECS_COMPONENT_NOT_REGISTERED :: (25)

/** Inconsistent component id error code. */
ECS_INCONSISTENT_COMPONENT_ID :: (26)

/** Inconsistent component action error code. */
ECS_INCONSISTENT_COMPONENT_ACTION :: (27)

/** Module undefined error code. */
ECS_MODULE_UNDEFINED :: (28)

/** Missing symbol error code. */
ECS_MISSING_SYMBOL :: (29)

/** Already in use error code. */
ECS_ALREADY_IN_USE :: (30)

/** Access violation error code. */
ECS_ACCESS_VIOLATION :: (40)

/** Column index out of range error code. */
ECS_COLUMN_INDEX_OUT_OF_RANGE :: (41)

/** Column is not shared error code. */
ECS_COLUMN_IS_NOT_SHARED :: (42)

/** Column is shared error code. */
ECS_COLUMN_IS_SHARED :: (43)

/** Column type mismatch error code. */
ECS_COLUMN_TYPE_MISMATCH :: (45)

/** Invalid while readonly error code. */
ECS_INVALID_WHILE_READONLY :: (70)

/** Locked storage error code. */
ECS_LOCKED_STORAGE :: (71)

/** Invalid from worker error code. */
ECS_INVALID_FROM_WORKER :: (72)

////////////////////////////////////////////////////////////////////////////////
//// Used when logging with colors is enabled
////////////////////////////////////////////////////////////////////////////////

/** Black ANSI color escape code. */
ECS_BLACK   :: "\033[1;30m"

/** Red ANSI color escape code. */
ECS_RED     :: "\033[0;31m"

/** Green ANSI color escape code. */
ECS_GREEN   :: "\033[0;32m"

/** Yellow ANSI color escape code. */
ECS_YELLOW  :: "\033[0;33m"

/** Blue ANSI color escape code. */
ECS_BLUE    :: "\033[0;34m"

/** Magenta ANSI color escape code. */
ECS_MAGENTA :: "\033[0;35m"

/** Cyan ANSI color escape code. */
ECS_CYAN    :: "\033[0;36m"

/** White ANSI color escape code. */
ECS_WHITE   :: "\033[1;37m"

/** Grey ANSI color escape code. */
ECS_GREY    :: "\033[0;37m"

/** Normal ANSI color escape code. */
ECS_NORMAL  :: "\033[0;49m"

/** Bold ANSI escape code. */
ECS_BOLD    :: "\033[1;49m"

/** Callback type for init action. */
ecs_app_init_action_t :: proc "c" (world: ^ecs_world_t) -> i32

/** Used with ecs_app_run(). */
ecs_app_desc_t :: struct {
	target_fps:   f32,                   /**< Target FPS. */
	delta_time:   f32,                   /**< Frame time increment (0 for measured values). */
	threads:      i32,                   /**< Number of threads. */
	frames:       i32,                   /**< Number of frames to run (0 for infinite). */
	enable_rest:  bool,                  /**< Enables ECS access over HTTP, necessary for the explorer. */
	enable_stats: bool,                  /**< Periodically collects statistics. */
	port:         u16,                   /**< HTTP port used by REST API. */
	init:         ecs_app_init_action_t, /**< If set, the function is run before starting the
                                 * main loop. */
	ctx:          rawptr,                /**< Reserved for custom run and frame actions. */
}

/** Callback type for run action. */
ecs_app_run_action_t :: proc "c" (world: ^ecs_world_t, desc: ^ecs_app_desc_t) -> i32

/** Callback type for frame action. */
ecs_app_frame_action_t :: proc "c" (world: ^ecs_world_t, desc: ^ecs_app_desc_t) -> i32

@(default_calling_convention="c")
foreign lib {
	/** Run application.
	* This will run the application with the parameters specified in desc. After
	* the application quits (ecs_quit() is called), the world will be cleaned up.
	*
	* If a custom run action is set, it will be invoked by this operation. The
	* default run action calls the frame action in a loop until it returns a
	* non-zero value.
	*
	* @param world The world.
	* @param desc Application parameters.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_app_run :: proc(world: ^ecs_world_t, desc: ^ecs_app_desc_t) -> i32 ---

	/** Default frame callback.
	* This operation will run a single frame. By default, this operation will invoke
	* ecs_progress() directly, unless a custom frame action is set.
	*
	* @param world The world.
	* @param desc The desc struct passed to ecs_app_run().
	* @return Value returned by ecs_progress().
	*/
	ecs_app_run_frame :: proc(world: ^ecs_world_t, desc: ^ecs_app_desc_t) -> i32 ---

	/** Set custom run action.
	* See ecs_app_run().
	*
	* @param callback The run action.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_app_set_run_action :: proc(callback: ecs_app_run_action_t) -> i32 ---

	/** Set custom frame action.
	* See ecs_app_run_frame().
	*
	* @param callback The frame action.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_app_set_frame_action :: proc(callback: ecs_app_frame_action_t) -> i32 ---
}

/** Maximum number of headers in a request. */
ECS_HTTP_HEADER_COUNT_MAX :: (32)

/** Maximum number of query parameters in a request. */
ECS_HTTP_QUERY_PARAM_COUNT_MAX :: (32)

ecs_http_server_t :: struct {}

/** A connection manages communication with the remote host. */
ecs_http_connection_t :: struct {
	id:     u64,                /**< Connection ID. */
	server: ^ecs_http_server_t, /**< Server. */
	host:   [128]i8,            /**< Remote host. */
	port:   [16]i8,             /**< Remote port. */
}

/** Helper type used for headers and URL query parameters. */
ecs_http_key_value_t :: struct {
	key:   cstring, /**< Key. */
	value: cstring, /**< Value. */
}

/** Supported request methods. */
ecs_http_method_t :: enum i32 {
	Get               = 0,
	Post              = 1,
	Put               = 2,
	Delete            = 3,
	Options           = 4,
	MethodUnsupported = 5,
}

/** An HTTP request. */
ecs_http_request_t :: struct {
	id:           u64,                      /**< Request ID. */
	method:       ecs_http_method_t,        /**< Request method. */
	path:         cstring,                  /**< Request path. */
	body:         cstring,                  /**< Request body. */
	headers:      [32]ecs_http_key_value_t, /**< Request headers. */
	params:       [32]ecs_http_key_value_t, /**< Request query parameters. */
	header_count: i32,                      /**< Number of headers. */
	param_count:  i32,                      /**< Number of query parameters. */
	conn:         ^ecs_http_connection_t,   /**< Connection. */
}

/** An HTTP reply. */
ecs_http_reply_t :: struct {
	code:         i32,          /**< default = 200. */
	body:         ecs_strbuf_t, /**< default = "". */
	status:       cstring,      /**< default = OK. */
	content_type: cstring,      /**< default = application/json. */
	headers:      ecs_strbuf_t, /**< default = "". */
}

/** Default initializer for ecs_http_reply_t. */
ECS_HTTP_REPLY_INIT :: (ecs_http_reply_t){200, ECS_STRBUF_INIT, "OK", "application/json", ECS_STRBUF_INIT}

/** Request callback.
* Invoked for each valid request. The function should populate the reply and
* return true. When the function returns false, the server will reply with a
* 404 (Not found) code. */
ecs_http_reply_action_t :: proc "c" (request: ^ecs_http_request_t, reply: ^ecs_http_reply_t, ctx: rawptr) -> bool

/** Used with ecs_http_server_init(). */
ecs_http_server_desc_t :: struct {
	callback:            ecs_http_reply_action_t, /**< Function called for each request. */
	ctx:                 rawptr,                  /**< Passed to callback (optional). */
	port:                u16,                     /**< HTTP port. */
	ipaddr:              cstring,                 /**< Interface to listen on (optional). */
	send_queue_wait_ms:  i32,                     /**< Send queue wait time when empty. */
	cache_timeout:       f64,                     /**< Cache invalidation timeout (0 disables caching). */
	cache_purge_timeout: f64,                     /**< Cache purge timeout (for purging cache entries). */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a server.
	* Use ecs_http_server_start() to start receiving requests.
	*
	* @param desc Server configuration parameters.
	* @return The new server, or NULL if creation failed.
	*/
	ecs_http_server_init :: proc(desc: ^ecs_http_server_desc_t) -> ^ecs_http_server_t ---

	/** Destroy a server.
	* This operation will stop the server if it was still running.
	*
	* @param server The server to destroy.
	*/
	ecs_http_server_fini :: proc(server: ^ecs_http_server_t) ---

	/** Start a server.
	* After this operation, the server will be able to accept requests.
	*
	* @param server The server to start.
	* @return Zero if successful, non-zero if failed.
	*/
	ecs_http_server_start :: proc(server: ^ecs_http_server_t) -> i32 ---

	/** Process server requests.
	* This operation invokes the reply callback for each received request. No new
	* requests will be enqueued while processing requests.
	*
	* @param server The server for which to process requests.
	* @param delta_time The time passed since the last call to dequeue.
	*/
	ecs_http_server_dequeue :: proc(server: ^ecs_http_server_t, delta_time: f32) ---

	/** Stop a server.
	* After this operation, no new requests can be received.
	*
	* @param server The server.
	*/
	ecs_http_server_stop :: proc(server: ^ecs_http_server_t) ---

	/** Emulate a request.
	* The request string must be a valid HTTP request. A minimal example:
	*
	*     GET /entity/flecs/core/World?label=true HTTP/1.1
	*
	* @param srv The server.
	* @param req The request.
	* @param len The length of the request (optional).
	* @param reply_out The reply (out parameter).
	* @return Zero if success, non-zero if failed.
	*/
	ecs_http_server_http_request :: proc(srv: ^ecs_http_server_t, req: cstring, len: ecs_size_t, reply_out: ^ecs_http_reply_t) -> i32 ---

	/** Convenience wrapper around ecs_http_server_http_request().
	*
	* @param srv The server.
	* @param method The HTTP method (e.g., "GET").
	* @param req The request path.
	* @param body The request body (optional).
	* @param reply_out The reply (out parameter).
	* @return Zero if success, non-zero if failed.
	*/
	ecs_http_server_request :: proc(srv: ^ecs_http_server_t, method: cstring, req: cstring, body: cstring, reply_out: ^ecs_http_reply_t) -> i32 ---

	/** Get context provided in ecs_http_server_desc_t.
	*
	* @param srv The server.
	* @return The context.
	*/
	ecs_http_server_ctx :: proc(srv: ^ecs_http_server_t) -> rawptr ---

	/** Find a header in a request.
	*
	* @param req The request.
	* @param name Name of the header to find.
	* @return The header value, or NULL if not found.
	*/
	ecs_http_get_header :: proc(req: ^ecs_http_request_t, name: cstring) -> cstring ---

	/** Find a query parameter in a request.
	*
	* @param req The request.
	* @param name The parameter name.
	* @return The decoded parameter value, or NULL if not found.
	*/
	ecs_http_get_param :: proc(req: ^ecs_http_request_t, name: cstring) -> cstring ---
}

/** Default port for the REST API server. */
ECS_REST_DEFAULT_PORT :: (27750)

/** Private REST data. */
ecs_rest_ctx_t :: struct {
	world:        ^ecs_world_t,       /**< The world. */
	srv:          ^ecs_http_server_t, /**< HTTP server instance. */
	rc:           i32,                /**< Reference count. */
	cmd_captures: ecs_map_t,          /**< Map of command captures. */
	last_time:    f64,                /**< Last processing time. */
}

/** Component that creates a REST API server when instantiated. */
EcsRest :: struct {
	port:   u16,             /**< Port of server (optional, default = 27750). */
	ipaddr: cstring,         /**< Interface address (optional, default = 0.0.0.0). */
	impl:   ^ecs_rest_ctx_t, /**< Private implementation data. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create HTTP server for REST API.
	* This allows for the creation of a REST server that can be managed by the
	* application without using Flecs systems.
	*
	* @param world The world.
	* @param desc The HTTP server descriptor.
	* @return The HTTP server, or NULL if failed.
	*/
	ecs_rest_server_init :: proc(world: ^ecs_world_t, desc: ^ecs_http_server_desc_t) -> ^ecs_http_server_t ---

	/** Clean up REST HTTP server.
	* The server must have been created with ecs_rest_server_init().
	*
	* @param srv The server to destroy.
	*/
	ecs_rest_server_fini :: proc(srv: ^ecs_http_server_t) ---

	/** REST module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsRest)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsRestImport :: proc(world: ^ecs_world_t) ---
}

/** Component used for one-shot and interval timer functionality. */
EcsTimer :: struct {
	timeout:     f32,  /**< Timer timeout period. */
	time:        f32,  /**< Incrementing time value. */
	overshoot:   f32,  /**< Used to correct returned interval time. */
	fired_count: i32,  /**< Number of times ticked. */
	active:      bool, /**< Is the timer active or not. */
	single_shot: bool, /**< Is this a single-shot timer. */
}

/** Apply a rate filter to a tick source. */
EcsRateFilter :: struct {
	src:          ecs_entity_t, /**< Source of the rate filter. */
	rate:         i32,          /**< Rate of the rate filter. */
	tick_count:   i32,          /**< Number of times the rate filter ticked. */
	time_elapsed: f32,          /**< Time elapsed since last tick. */
}

@(default_calling_convention="c")
foreign lib {
	/** Set timer timeout.
	* This operation executes any systems associated with the timer after the
	* specified timeout value. If the entity contains an existing timer, the
	* timeout value will be reset. The timer can be started and stopped with
	* ecs_start_timer() and ecs_stop_timer().
	*
	* The timer is synchronous, and is incremented each frame by delta_time.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The timer for which to set the timeout (0 to create one).
	* @param timeout The timeout value.
	* @return The timer entity.
	*/
	ecs_set_timeout :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t, timeout: f32) -> ecs_entity_t ---

	/** Get current timeout value for the specified timer.
	* This operation returns the value set by ecs_set_timeout(). If no timer is
	* active for this entity, the operation returns 0.
	*
	* After the timeout expires the EcsTimer component is removed from the entity.
	* This means that if ecs_get_timeout() is invoked after the timer is expired, the
	* operation will return 0.
	*
	* @param world The world.
	* @param tick_source The timer.
	* @return The current timeout value, or 0 if no timer is active.
	*/
	ecs_get_timeout :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t) -> f32 ---

	/** Set timer interval.
	* This operation will continuously invoke systems associated with the timer
	* after the interval period expires. If the entity contains an existing timer,
	* the interval value will be reset.
	*
	* The timer is synchronous, and is incremented each frame by delta_time.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The timer for which to set the interval (0 to create one).
	* @param interval The interval value.
	* @return The timer entity.
	*/
	ecs_set_interval :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t, interval: f32) -> ecs_entity_t ---

	/** Get current interval value for the specified timer.
	* This operation returns the value set by ecs_set_interval(). If the entity is
	* not a timer, the operation will return 0.
	*
	* @param world The world.
	* @param tick_source The timer for which to get the interval.
	* @return The current interval value, or 0 if no timer is active.
	*/
	ecs_get_interval :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t) -> f32 ---

	/** Start timer.
	* This operation resets the timer and starts it with the specified timeout.
	*
	* @param world The world.
	* @param tick_source The timer to start.
	*/
	ecs_start_timer :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t) ---

	/** Stop timer.
	* This operation stops a timer from triggering.
	*
	* @param world The world.
	* @param tick_source The timer to stop.
	*/
	ecs_stop_timer :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t) ---

	/** Reset time value of timer to 0.
	* This operation resets the timer value to 0.
	*
	* @param world The world.
	* @param tick_source The timer to reset.
	*/
	ecs_reset_timer :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t) ---

	/** Enable randomizing initial time value of timers.
	* Initializes timers with a random time value, which can improve scheduling as
	* systems/timers for the same interval don't all happen on the same tick.
	*
	* @param world The world.
	*/
	ecs_randomize_timers :: proc(world: ^ecs_world_t) ---

	/** Set rate filter.
	* This operation initializes a rate filter. Rate filters sample tick sources
	* and tick at a configurable multiple. A rate filter is a tick source itself,
	* which means that rate filters can be chained.
	*
	* Rate filters enable deterministic system execution which cannot be achieved
	* with interval timers alone. For example, if timer A has interval 2.0 and
	* timer B has interval 4.0, it is not guaranteed that B will tick at exactly
	* twice the multiple of A. This is partly due to the nondeterministic nature of
	* timers, and partly due to floating-point rounding errors.
	*
	* Rate filters can be combined with timers (or other rate filters) to ensure
	* that a system ticks at an exact multiple of a tick source (which can be
	* another system). If a rate filter is created with a rate of 1, it will tick
	* at the exact same time as its source.
	*
	* If no tick source is provided, the rate filter will use the frame tick as
	* source, which corresponds with the number of times ecs_progress() is called.
	*
	* The tick_source entity will be a tick source after this operation. Tick
	* sources can be read by getting the EcsTickSource component. If the tick
	* source ticked this frame, the 'tick' member will be true. When the tick
	* source is a system, the system will tick when the timer ticks.
	*
	* @param world The world.
	* @param tick_source The rate filter entity (0 to create one).
	* @param rate The rate to apply.
	* @param source The tick source (0 to use frames).
	* @return The rate filter entity.
	*/
	ecs_set_rate :: proc(world: ^ecs_world_t, tick_source: ecs_entity_t, rate: i32, source: ecs_entity_t) -> ecs_entity_t ---

	/** Assign tick source to system.
	* Systems can be their own tick source, which can be any of the tick sources
	* (one-shot timers, interval timers, and rate filters). However, in some cases it
	* must be guaranteed that different systems tick on the exact same frame.
	*
	* This cannot be guaranteed by giving two systems the same interval/rate filter
	* as it is possible that one system is (for example) disabled, which would
	* cause the systems to go out of sync. To provide these guarantees, systems
	* must use the same tick source, which is what this operation enables.
	*
	* When two systems share the same tick source, it is guaranteed that they tick
	* in the same frame. The provided tick source can be any entity that is a tick
	* source, including another system. If the provided entity is not a tick source
	* the system will not be run.
	*
	* To disassociate a tick source from a system, use 0 for the tick_source
	* parameter.
	*
	* @param world The world.
	* @param system The system to associate with the timer.
	* @param tick_source The tick source to associate with the system.
	*/
	ecs_set_tick_source :: proc(world: ^ecs_world_t, system: ecs_entity_t, tick_source: ecs_entity_t) ---

	/** Timer module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsTimer)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsTimerImport :: proc(world: ^ecs_world_t) ---
}

/** Pipeline descriptor, used with ecs_pipeline_init(). */
ecs_pipeline_desc_t :: struct {
	/** Existing entity to associate with the pipeline (optional). */
	entity: ecs_entity_t,

	/** The pipeline query.
	* Pipelines are queries that are matched with system entities. Pipeline
	* queries are the same as regular queries, which means the same query rules
	* apply. A common mistake is to try a pipeline that matches systems in a
	* list of phases by specifying all the phases, like:
	*   OnUpdate, OnPhysics, OnRender
	*
	* That however creates a query that matches entities with OnUpdate _and_
	* OnPhysics _and_ OnRender tags, which is likely undesired. Instead, a
	* query could use the or operator to match a system that has one of the
	* specified phases:
	*   OnUpdate || OnPhysics || OnRender
	*
	* This will return the correct set of systems, but they likely won't be in
	* the correct order. To make sure systems are returned in the correct order,
	* two query ordering features can be used:
	* - group_by
	* - order_by
	*
	* Take a look at the system manual for a more detailed explanation of
	* how query features can be applied to pipelines, and how the built-in
	* pipeline query works.
	*/
	query: ecs_query_desc_t,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a custom pipeline.
	* If the descriptor specifies an existing entity, the entity must not already
	* be associated with a pipeline. To replace an existing pipeline on an
	* entity, use ecs_pipeline_update().
	*
	* @param world The world.
	* @param desc The pipeline descriptor.
	* @return The pipeline, 0 if failed.
	*/
	ecs_pipeline_init :: proc(world: ^ecs_world_t, desc: ^ecs_pipeline_desc_t) -> ecs_entity_t ---

	/** Replace the pipeline query on an existing entity.
	* Removes the pipeline currently attached to the entity and creates a new one
	* from the descriptor.
	*
	* @param world The world.
	* @param pipeline The pipeline entity to update.
	* @param desc The pipeline descriptor.
	* @return The pipeline entity, or 0 if the operation failed.
	*/
	ecs_pipeline_update :: proc(world: ^ecs_world_t, pipeline: ecs_entity_t, desc: ^ecs_pipeline_desc_t) -> ecs_entity_t ---

	/** Set a custom pipeline.
	* This operation sets the pipeline to run when ecs_progress() is invoked.
	*
	* @param world The world.
	* @param pipeline The pipeline to set.
	*/
	ecs_set_pipeline :: proc(world: ^ecs_world_t, pipeline: ecs_entity_t) ---

	/** Get the current pipeline.
	* This operation gets the current pipeline.
	*
	* @param world The world.
	* @return The current pipeline.
	*/
	ecs_get_pipeline :: proc(world: ^ecs_world_t) -> ecs_entity_t ---

	/** Progress a world.
	* This operation progresses the world by running all systems that are both
	* enabled and periodic on their matching entities.
	*
	* An application can pass a delta_time into the function, which is the time
	* passed since the last frame. This value is passed to systems so they can
	* update entity values proportional to the elapsed time since their last
	* invocation.
	*
	* When an application passes 0 to delta_time, ecs_progress() will automatically
	* measure the time passed since the last frame. If an application does not use
	* time management, it should pass a non-zero value for delta_time (1.0 is
	* recommended). That way, no time will be wasted measuring the time.
	*
	* @param world The world to progress.
	* @param delta_time The time passed since the last frame.
	* @return false if ecs_quit() has been called, true otherwise.
	*/
	ecs_progress :: proc(world: ^ecs_world_t, delta_time: f32) -> bool ---

	/** Set time scale.
	* Increase or decrease simulation speed by the provided multiplier.
	*
	* @param world The world.
	* @param scale The scale to apply (default = 1).
	*/
	ecs_set_time_scale :: proc(world: ^ecs_world_t, scale: f32) ---

	/** Reset world clock.
	* Reset the clock that keeps track of the total time passed in the simulation.
	*
	* @param world The world.
	*/
	ecs_reset_clock :: proc(world: ^ecs_world_t) ---

	/** Run pipeline.
	* This will run all systems in the provided pipeline. This operation may be
	* invoked from multiple threads, and only when staging is disabled, as the
	* pipeline manages staging and, if necessary, synchronization between threads.
	*
	* If 0 is provided for the pipeline ID, the default pipeline will be run (this
	* is either the built-in pipeline or the pipeline set with ecs_set_pipeline()).
	*
	* When using ecs_progress(), this operation will be invoked automatically for
	* the default pipeline (either the built-in pipeline or the pipeline set with
	* ecs_set_pipeline()). An application may run additional pipelines.
	*
	* @param world The world.
	* @param pipeline The pipeline to run.
	* @param delta_time The delta_time to pass to systems.
	*/
	ecs_run_pipeline :: proc(world: ^ecs_world_t, pipeline: ecs_entity_t, delta_time: f32) ---

	/** Set number of worker threads.
	* Setting this value to a value higher than 1 will start that many threads and
	* will cause systems to evenly distribute matched entities across threads. The
	* operation may be called multiple times to reconfigure the number of threads
	* used, but never while running a system or pipeline.
	* Calling ecs_set_threads() will also end the use of task threads set up with
	* ecs_set_task_threads() and vice-versa.
	*
	* @param world The world.
	* @param threads The number of threads to create.
	*/
	ecs_set_threads :: proc(world: ^ecs_world_t, threads: i32) ---

	/** Set number of worker task threads.
	* ecs_set_task_threads() is similar to ecs_set_threads(), except threads are treated
	* as short-lived tasks and will be created and joined around each update of the world.
	* Creation and joining of these tasks will use the os_api_t task APIs rather than
	* the standard thread API functions, although they may be the same if desired.
	* This function is useful for multithreading world updates using an external
	* asynchronous job system rather than long-running threads by providing the APIs
	* to create tasks for your job system and then wait on their conclusion.
	* The operation may be called multiple times to reconfigure the number of task threads
	* used, but never while running a system or pipeline.
	* Calling ecs_set_task_threads() will also end the use of threads set up with
	* ecs_set_threads() and vice-versa.
	*
	* @param world The world.
	* @param task_threads The number of task threads to create.
	*/
	ecs_set_task_threads :: proc(world: ^ecs_world_t, task_threads: i32) ---

	/** Return true if task thread use has been requested.
	*
	* @param world The world.
	* @return Whether the world is using task threads.
	*/
	ecs_using_task_threads :: proc(world: ^ecs_world_t) -> bool ---

	/** Pipeline module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsPipeline)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsPipelineImport :: proc(world: ^ecs_world_t) ---
}

/** Component used to provide a tick source to systems. */
EcsTickSource :: struct {
	tick:         bool, /**< True if providing a tick. */
	time_elapsed: f32,  /**< Time elapsed since the last tick. */
}

/** Use with ecs_system_init() and ecs_system_update(). */
ecs_system_desc_t :: struct {
	_canary: i32, /**< Used for validity testing. Do not set. */

	/** Existing entity to associate with the system (optional). */
	entity: ecs_entity_t,

	/** System query parameters. */
	query: ecs_query_desc_t,

	/** Optional pipeline phase for the system to run in. When set, it will be
	* added to the system both as a tag and as a (DependsOn, phase) pair. */
	phase: ecs_entity_t,

	/** Callback that is run for each result returned by the system's query. This
	* means that this callback can be invoked multiple times per system per
	* frame, typically once for each matching table. */
	callback: ecs_iter_action_t,

	/** Callback that is invoked when a system is run.
	* When left to NULL, the default system runner is used, which calls the
	* "callback" action for each result returned from the system's query.
	*
	* It should not be assumed that the input iterator can always be iterated
	* with ecs_query_next(). When a system is multithreaded and/or paged, the
	* iterator can be either a worker or a paged iterator. The correct function
	* to use for iteration is ecs_iter_next().
	*
	* An implementation can test whether the iterator is a query iterator by
	* testing whether the it->next value is equal to ecs_query_next(). */
	run: ecs_run_action_t,

	/** Context to be passed to callback (as ecs_iter_t::param). */
	ctx: rawptr,

	/** Callback to free ctx. */
	ctx_free: ecs_ctx_free_t,

	/** Context associated with callback (for language bindings). */
	callback_ctx: rawptr,

	/** Callback to free callback ctx. */
	callback_ctx_free: ecs_ctx_free_t,

	/** Context associated with run (for language bindings). */
	run_ctx: rawptr,

	/** Callback to free run ctx. */
	run_ctx_free: ecs_ctx_free_t,

	/** Interval in seconds at which the system should run. */
	interval: f32,

	/** Rate at which the system should run. */
	rate: i32,

	/** External tick source that determines when the system ticks. */
	tick_source: ecs_entity_t,

	/** If true, the system will be run on multiple threads. */
	multi_threaded: bool,

	/** If true, the system will have access to the actual world. Cannot be true at the
	* same time as multi_threaded. */
	immediate: bool,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a system.
	* If the descriptor specifies an existing entity, the entity must not already
	* be associated with a system. To modify an existing system, use
	* ecs_system_update().
	*
	* @param world The world.
	* @param desc The system descriptor.
	* @return The system entity.
	*/
	ecs_system_init :: proc(world: ^ecs_world_t, desc: ^ecs_system_desc_t) -> ecs_entity_t ---

	/** Update an existing system.
	* Updates the configuration of a system that was previously created with
	* ecs_system_init(). Only fields in desc that are set to a non-default value
	* will be applied; fields left at their default value preserve the existing
	* configuration of the system.
	*
	* The query field of the descriptor is not used by this function; the system
	* query cannot be modified after creation.
	*
	* @param world The world.
	* @param system The system to update.
	* @param desc The system descriptor.
	* @return The system entity, or 0 if the operation failed.
	*/
	ecs_system_update :: proc(world: ^ecs_world_t, system: ecs_entity_t, desc: ^ecs_system_desc_t) -> ecs_entity_t ---
}

/** System type, get with ecs_system_get(). */
ecs_system_t :: struct {
	hdr: ecs_header_t, /**< Object header. */

	/** See ecs_system_desc_t. */
	run: ecs_run_action_t,

	/** See ecs_system_desc_t. */
	action: ecs_iter_action_t,

	/** System query. */
	query: ^ecs_query_t,

	/** Query group to iterate. */
	group_id: u64,

	/** True if a query group is configured. */
	group_id_set: bool,

	/** Tick source associated with the system. */
	tick_source: ecs_entity_t,

	/** Whether the system is multithreaded. */
	multi_threaded: bool,

	/** Whether the system is run in immediate mode. */
	immediate: bool,

	/** Cached system name (for perf tracing). */
	name: cstring,

	/** Userdata for the system. */
	ctx: rawptr,

	/** Callback language binding context. */
	callback_ctx: rawptr,

	/** Run language binding context. */
	run_ctx: rawptr,

	/** Callback to free ctx. */
	ctx_free: ecs_ctx_free_t,

	/** Callback to free callback ctx. */
	callback_ctx_free: ecs_ctx_free_t,

	/** Callback to free run ctx. */
	run_ctx_free: ecs_ctx_free_t,

	/** Time spent on running the system. */
	time_spent: f32,

	/** Time passed since the last invocation. */
	time_passed: f32,

	/** Last frame for which the system was considered. */
	last_frame: i64,

	/** Mixin destructor. */
	dtor: flecs_poly_dtor_t,
}

@(default_calling_convention="c")
foreign lib {
	/** Get a system object.
	* Return the system object. Can be used to access various information about
	* the system, like the query and context.
	*
	* @param world The world.
	* @param system The system.
	* @return The system object.
	*/
	ecs_system_get :: proc(world: ^ecs_world_t, system: ecs_entity_t) -> ^ecs_system_t ---

	/** Set query group for system.
	* This operation configures a system created with a grouped query to only
	* iterate results for the specified group ID. The group filter is applied to
	* both manual runs and pipeline execution.
	*
	* @param world The world.
	* @param system The system.
	* @param group_id The query group ID to iterate.
	*/
	ecs_system_set_group :: proc(world: ^ecs_world_t, system: ecs_entity_t, group_id: u64) ---

	/** Run a specific system manually.
	* This operation runs a single system manually. It is an efficient way to
	* invoke logic on a set of entities, as manual systems are only matched to
	* tables at creation time or after creation time, when a new table is created.
	*
	* Manual systems are useful to evaluate lists of pre-matched entities at
	* application-defined times. Because none of the matching logic is evaluated
	* before the system is invoked, manual systems are much more efficient than
	* manually obtaining a list of entities and retrieving their components.
	*
	* An application may pass custom data to a system through the param parameter.
	* This data can be accessed by the system through the param member in the
	* ecs_iter_t value that is passed to the system callback.
	*
	* Any system may interrupt execution by setting the interrupted_by member in
	* the ecs_iter_t value. This is particularly useful for manual systems, where
	* the value of interrupted_by is returned by this operation. This, in
	* combination with the param argument, lets applications use manual systems
	* to lookup entities: once the entity has been found, its handle is passed to
	* interrupted_by, which is then subsequently returned.
	*
	* @param world The world.
	* @param system The system to run.
	* @param delta_time The time passed since the last system invocation.
	* @param param A user-defined parameter to pass to the system.
	* @return Handle to the last evaluated entity if the system was interrupted.
	*/
	ecs_run :: proc(world: ^ecs_world_t, system: ecs_entity_t, delta_time: f32, param: rawptr) -> ecs_entity_t ---

	/** Same as ecs_run(), but subdivides entities across a number of provided stages.
	*
	* @param world The world.
	* @param system The system to run.
	* @param stage_current The ID of the current stage.
	* @param stage_count The total number of stages.
	* @param delta_time The time passed since the last system invocation.
	* @param param A user-defined parameter to pass to the system.
	* @return Handle to the last evaluated entity if the system was interrupted.
	*/
	ecs_run_worker :: proc(world: ^ecs_world_t, system: ecs_entity_t, stage_current: i32, stage_count: i32, delta_time: f32, param: rawptr) -> ecs_entity_t ---

	/** System module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsSystem)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsSystemImport :: proc(world: ^ecs_world_t) ---
}

/** Number of samples in the stat window. */
ECS_STAT_WINDOW :: (60)

/** Simple value that indicates current state. */
ecs_gauge_t :: struct {
	avg: [60]f32, /**< Windowed average. */
	min: [60]f32, /**< Windowed minimum. */
	max: [60]f32, /**< Windowed maximum. */
}

/** Monotonically increasing counter. */
ecs_counter_t :: struct {
	rate:  ecs_gauge_t, /**< Keep track of deltas too. */
	value: [60]f64,     /**< Monotonically increasing values. */
}

/** Make all metrics the same size, so we can iterate over fields. */
ecs_metric_t :: struct #raw_union {
	gauge:   ecs_gauge_t,   /**< Gauge metric. */
	counter: ecs_counter_t, /**< Counter metric. */
}

/** Type that contains world statistics. */
ecs_world_stats_t :: struct {
	first_: i64, /**< Used for field iteration. Do not set. */

	entities: struct {
		count:           ecs_metric_t, /**< Number of entities. */
		not_alive_count: ecs_metric_t, /**< Number of not alive (recyclable) entity IDs. */
	},

	components: struct {
		tag_count:       ecs_metric_t, /**< Number of tag IDs (IDs without data). */
		component_count: ecs_metric_t, /**< Number of component IDs (IDs with data). */
		pair_count:      ecs_metric_t, /**< Number of pair IDs. */
		type_count:      ecs_metric_t, /**< Number of registered types. */
		create_count:    ecs_metric_t, /**< Number of times an ID has been created. */
		delete_count:    ecs_metric_t, /**< Number of times an ID has been deleted. */
	},

	tables: struct {
		count:        ecs_metric_t, /**< Number of tables. */
		empty_count:  ecs_metric_t, /**< Number of empty tables. */
		create_count: ecs_metric_t, /**< Number of times table has been created. */
		delete_count: ecs_metric_t, /**< Number of times table has been deleted. */
	},

	queries: struct {
		query_count:    ecs_metric_t, /**< Number of queries. */
		observer_count: ecs_metric_t, /**< Number of observers. */
		system_count:   ecs_metric_t, /**< Number of systems. */
	},

	commands: struct {
		add_count:            ecs_metric_t, /**< Number of add commands. */
		remove_count:         ecs_metric_t, /**< Number of remove commands. */
		delete_count:         ecs_metric_t, /**< Number of delete commands. */
		clear_count:          ecs_metric_t, /**< Number of clear commands. */
		set_count:            ecs_metric_t, /**< Number of set commands. */
		ensure_count:         ecs_metric_t, /**< Number of ensure commands. */
		modified_count:       ecs_metric_t, /**< Number of modified commands. */
		other_count:          ecs_metric_t, /**< Number of other commands. */
		discard_count:        ecs_metric_t, /**< Number of discarded commands. */
		batched_entity_count: ecs_metric_t, /**< Number of entities for which commands were batched. */
		batched_count:        ecs_metric_t, /**< Number of commands batched. */
	},

	frame: struct {
		frame_count:          ecs_metric_t, /**< Number of frames processed. */
		merge_count:          ecs_metric_t, /**< Number of merges executed. */
		rematch_count:        ecs_metric_t, /**< Number of query rematches. */
		pipeline_build_count: ecs_metric_t, /**< Number of system pipeline rebuilds (occurs when an inactive system becomes active). */
		systems_ran:          ecs_metric_t, /**< Number of systems run. */
		observers_ran:        ecs_metric_t, /**< Number of times an observer was invoked. */
		event_emit_count:     ecs_metric_t, /**< Number of events emitted. */
	},

	performance: struct {
		world_time_raw: ecs_metric_t, /**< Actual time passed since simulation start (first time progress() is called). */
		world_time:     ecs_metric_t, /**< Simulation time passed since simulation start. Takes into account time scaling. */
		frame_time:     ecs_metric_t, /**< Time spent processing a frame. Smaller than world_time_total when load is not 100%. */
		system_time:    ecs_metric_t, /**< Time spent on running systems. */
		emit_time:      ecs_metric_t, /**< Time spent on notifying observers. */
		merge_time:     ecs_metric_t, /**< Time spent on merging commands. */
		rematch_time:   ecs_metric_t, /**< Time spent on rematching. */
		fps:            ecs_metric_t, /**< Frames per second. */
		delta_time:     ecs_metric_t, /**< Delta time. */
	},

	memory: struct {
		/* Memory allocation data */
		alloc_count:             ecs_metric_t, /**< Allocs per frame. */
		realloc_count:           ecs_metric_t, /**< Reallocs per frame. */
		free_count:              ecs_metric_t, /**< Frees per frame. */
		outstanding_alloc_count: ecs_metric_t, /**< Difference between allocs and frees. */

		/* Memory allocator data */
		block_alloc_count:             ecs_metric_t, /**< Block allocations per frame. */
		block_free_count:              ecs_metric_t, /**< Block frees per frame. */
		block_outstanding_alloc_count: ecs_metric_t, /**< Difference between allocs and frees. */
		stack_alloc_count:             ecs_metric_t, /**< Page allocations per frame. */
		stack_free_count:              ecs_metric_t, /**< Page frees per frame. */
		stack_outstanding_alloc_count: ecs_metric_t, /**< Difference between allocs and frees. */
	},

	http: struct {
		request_received_count:      ecs_metric_t, /**< Number of HTTP requests received. */
		request_invalid_count:       ecs_metric_t, /**< Number of invalid HTTP requests. */
		request_handled_ok_count:    ecs_metric_t, /**< Number of successfully handled HTTP requests. */
		request_handled_error_count: ecs_metric_t, /**< Number of HTTP requests with error response. */
		request_not_handled_count:   ecs_metric_t, /**< Number of unhandled HTTP requests. */
		request_preflight_count:     ecs_metric_t, /**< Number of preflight HTTP requests. */
		send_ok_count:               ecs_metric_t, /**< Number of successful HTTP responses sent. */
		send_error_count:            ecs_metric_t, /**< Number of HTTP responses with send error. */
		busy_count:                  ecs_metric_t, /**< Number of times server was busy. */
	},

	last_: i64, /**< Used for field iteration. Do not set. */

	/** Current position in ring buffer. */
	t: i32,
}

/** Statistics for a single query (use ecs_query_cache_stats_get()). */
ecs_query_stats_t :: struct {
	first_:               i64,          /**< Used for field iteration. Do not set. */
	result_count:         ecs_metric_t, /**< Number of query results. */
	matched_table_count:  ecs_metric_t, /**< Number of matched tables. */
	matched_entity_count: ecs_metric_t, /**< Number of matched entities. */
	last_:                i64,          /**< Used for field iteration. Do not set. */

	/** Current position in ring buffer. */
	t: i32,
}

/** Statistics for a single system (use ecs_system_stats_get()). */
ecs_system_stats_t :: struct {
	first_:     i64,               /**< Used for field iteration. Do not set. */
	time_spent: ecs_metric_t,      /**< Time spent processing a system. */
	last_:      i64,               /**< Used for field iteration. Do not set. */
	task:       bool,              /**< Whether the system is a task. */
	query:      ecs_query_stats_t, /**< Query statistics. */
}

/** Statistics for sync point. */
ecs_sync_stats_t :: struct {
	first_:            i64,          /**< Used for field iteration. Do not set. */
	time_spent:        ecs_metric_t, /**< Time spent in sync point. */
	commands_enqueued: ecs_metric_t, /**< Number of commands enqueued. */
	last_:             i64,          /**< Used for field iteration. Do not set. */
	system_count:      i32,          /**< Number of systems before sync point. */
	multi_threaded:    bool,         /**< Whether the sync point is multi-threaded. */
	immediate:         bool,         /**< Whether the sync point is immediate. */
}

/** Statistics for all systems in a pipeline. */
ecs_pipeline_stats_t :: struct {
	canary_: i8, /**< Allow for initializing struct with {0}. Do not set. */

	/** Vector with system IDs of all systems in the pipeline. The systems are
	* stored in the order they are executed. Merges are represented by a 0. */
	systems: ecs_vec_t,

	/** Vector with sync point stats. */
	sync_points: ecs_vec_t,

	/** Current position in ring buffer. */
	t:                   i32,
	system_count:        i32, /**< Number of systems in pipeline. */
	active_system_count: i32, /**< Number of active systems in pipeline. */
	rebuild_count:       i32, /**< Number of times pipeline has rebuilt. */
}

@(default_calling_convention="c")
foreign lib {
	/** Get world statistics.
	*
	* @param world The world.
	* @param stats Out parameter for statistics.
	*/
	ecs_world_stats_get :: proc(world: ^ecs_world_t, stats: ^ecs_world_stats_t) ---

	/** Reduce source measurement window into single destination measurement. */
	ecs_world_stats_reduce :: proc(dst: ^ecs_world_stats_t, src: ^ecs_world_stats_t) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	ecs_world_stats_reduce_last :: proc(stats: ^ecs_world_stats_t, old: ^ecs_world_stats_t, count: i32) ---

	/** Repeat last measurement. */
	ecs_world_stats_repeat_last :: proc(stats: ^ecs_world_stats_t) ---

	/** Copy last measurement from source to destination. */
	ecs_world_stats_copy_last :: proc(dst: ^ecs_world_stats_t, src: ^ecs_world_stats_t) ---

	/** Log world statistics.
	*
	* @param world The world.
	* @param stats The statistics to log.
	*/
	ecs_world_stats_log :: proc(world: ^ecs_world_t, stats: ^ecs_world_stats_t) ---

	/** Get query statistics.
	* Obtain statistics for the provided query.
	*
	* @param world The world.
	* @param query The query.
	* @param stats Out parameter for statistics.
	*/
	ecs_query_stats_get :: proc(world: ^ecs_world_t, query: ^ecs_query_t, stats: ^ecs_query_stats_t) ---

	/** Reduce source measurement window into single destination measurement. */
	ecs_query_cache_stats_reduce :: proc(dst: ^ecs_query_stats_t, src: ^ecs_query_stats_t) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	ecs_query_cache_stats_reduce_last :: proc(stats: ^ecs_query_stats_t, old: ^ecs_query_stats_t, count: i32) ---

	/** Repeat last measurement. */
	ecs_query_cache_stats_repeat_last :: proc(stats: ^ecs_query_stats_t) ---

	/** Copy last measurement from source to destination. */
	ecs_query_cache_stats_copy_last :: proc(dst: ^ecs_query_stats_t, src: ^ecs_query_stats_t) ---

	/** Get system statistics.
	* Obtain statistics for the provided system.
	*
	* @param world The world.
	* @param system The system.
	* @param stats Out parameter for statistics.
	* @return true if success, false if not a system.
	*/
	ecs_system_stats_get :: proc(world: ^ecs_world_t, system: ecs_entity_t, stats: ^ecs_system_stats_t) -> bool ---

	/** Reduce source measurement window into single destination measurement. */
	ecs_system_stats_reduce :: proc(dst: ^ecs_system_stats_t, src: ^ecs_system_stats_t) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	ecs_system_stats_reduce_last :: proc(stats: ^ecs_system_stats_t, old: ^ecs_system_stats_t, count: i32) ---

	/** Repeat last measurement. */
	ecs_system_stats_repeat_last :: proc(stats: ^ecs_system_stats_t) ---

	/** Copy last measurement from source to destination. */
	ecs_system_stats_copy_last :: proc(dst: ^ecs_system_stats_t, src: ^ecs_system_stats_t) ---

	/** Get pipeline statistics.
	* Obtain statistics for the provided pipeline.
	*
	* @param world The world.
	* @param pipeline The pipeline.
	* @param stats Out parameter for statistics.
	* @return true if success, false if not a pipeline.
	*/
	ecs_pipeline_stats_get :: proc(world: ^ecs_world_t, pipeline: ecs_entity_t, stats: ^ecs_pipeline_stats_t) -> bool ---

	/** Free pipeline stats.
	*
	* @param stats The stats to free.
	*/
	ecs_pipeline_stats_fini :: proc(stats: ^ecs_pipeline_stats_t) ---

	/** Reduce source measurement window into single destination measurement. */
	ecs_pipeline_stats_reduce :: proc(dst: ^ecs_pipeline_stats_t, src: ^ecs_pipeline_stats_t) ---

	/** Reduce last measurement into previous measurement, restore old value. */
	ecs_pipeline_stats_reduce_last :: proc(stats: ^ecs_pipeline_stats_t, old: ^ecs_pipeline_stats_t, count: i32) ---

	/** Repeat last measurement. */
	ecs_pipeline_stats_repeat_last :: proc(stats: ^ecs_pipeline_stats_t) ---

	/** Copy last measurement to destination.
	* This operation copies the last measurement into the destination. It does not
	* modify the cursor.
	*
	* @param dst The metrics.
	* @param src The metrics to copy.
	*/
	ecs_pipeline_stats_copy_last :: proc(dst: ^ecs_pipeline_stats_t, src: ^ecs_pipeline_stats_t) ---

	/** Reduce all measurements from a window into a single measurement. */
	ecs_metric_reduce :: proc(dst: ^ecs_metric_t, src: ^ecs_metric_t, t_dst: i32, t_src: i32) ---

	/** Reduce last measurement into previous measurement. */
	ecs_metric_reduce_last :: proc(m: ^ecs_metric_t, t: i32, count: i32) ---

	/** Copy measurement. */
	ecs_metric_copy :: proc(m: ^ecs_metric_t, dst: i32, src: i32) ---
}

/** Common header for statistics types. */
EcsStatsHeader :: struct {
	elapsed:      f32, /**< Elapsed time since last reset. */
	reduce_count: i32, /**< Number of times statistics have been reduced. */
}

/** Component that stores world statistics. */
EcsWorldStats :: struct {
	hdr:   EcsStatsHeader,     /**< Statistics header. */
	stats: ^ecs_world_stats_t, /**< World statistics data. */
}

/** Component that stores system statistics. */
EcsSystemStats :: struct {
	hdr:   EcsStatsHeader, /**< Statistics header. */
	stats: ecs_map_t,      /**< Map of system statistics. */
}

/** Component that stores pipeline statistics. */
EcsPipelineStats :: struct {
	hdr:   EcsStatsHeader, /**< Statistics header. */
	stats: ecs_map_t,      /**< Map of pipeline statistics. */
}

/** Component that stores a summary of world statistics. */
EcsWorldSummary :: struct {
	/* Time */
	target_fps: f64, /**< Target FPS. */
	time_scale: f64, /**< Simulation time scale. */
	fps:        f64, /**< FPS. */

	/* Totals */
	frame_time_total:    f64, /**< Total time spent processing a frame. */
	system_time_total:   f64, /**< Total time spent in systems. */
	merge_time_total:    f64, /**< Total time spent in merges. */
	entity_count:        i64, /**< Number of entities. */
	table_count:         i64, /**< Number of tables. */
	frame_count:         i64, /**< Number of frames processed. */
	command_count:       i64, /**< Number of commands processed. */
	merge_count:         i64, /**< Number of merges executed. */
	systems_ran_total:   i64, /**< Total number of systems run. */
	observers_ran_total: i64, /**< Total number of times observers were invoked. */
	queries_ran_total:   i64, /**< Total number of queries run. */
	tag_count:           i32, /**< Number of tag (no data) IDs in the world. */
	component_count:     i32, /**< Number of component (data) IDs in the world. */
	pair_count:          i32, /**< Number of pair IDs in the world. */

	/* Per frame */
	frame_time_frame:    f64, /**< Time spent processing a frame. */
	system_time_frame:   f64, /**< Time spent in systems. */
	merge_time_frame:    f64, /**< Time spent in merges. */
	merge_count_frame:   i64, /**< Number of merges in last frame. */
	systems_ran_frame:   i64, /**< Number of systems run in last frame. */
	observers_ran_frame: i64, /**< Number of times observers were invoked in last frame. */
	queries_ran_frame:   i64, /**< Number of queries run in last frame. */
	command_count_frame: i64, /**< Number of commands processed in last frame. */
	simulation_time:     f64, /**< Time spent in simulation. */
	uptime:              u32, /**< Time since world was created. */

	/* Build info */
	build_info: ecs_build_info_t, /**< Build info. */
}

/** Entity memory. */
ecs_entities_memory_t :: struct {
	alive_count:        i32,        /**< Number of alive entities. */
	not_alive_count:    i32,        /**< Number of not alive entities. */
	bytes_entity_index: ecs_size_t, /**< Bytes used by entity index. */
	bytes_names:        ecs_size_t, /**< Bytes used by names, symbols, and aliases. */
	bytes_doc_strings:  ecs_size_t, /**< Bytes used by doc strings. */
}

/** Component memory. */
ecs_component_memory_t :: struct {
	instances:                     i32,        /**< Total number of component instances. */
	bytes_table_components:        ecs_size_t, /**< Bytes used by table columns. */
	bytes_table_components_unused: ecs_size_t, /**< Unused bytes in table columns. */
	bytes_toggle_bitsets:          ecs_size_t, /**< Bytes used in bitsets (toggled components). */
	bytes_sparse_components:       ecs_size_t, /**< Bytes used in component sparse sets. */
}

/** Component index memory. */
ecs_component_index_memory_t :: struct {
	count:                    i32,        /**< Number of component records. */
	bytes_component_record:   ecs_size_t, /**< Bytes used by ecs_component_record_t struct. */
	bytes_table_cache:        ecs_size_t, /**< Bytes used by table cache. */
	bytes_name_index:         ecs_size_t, /**< Bytes used by name index. */
	bytes_ordered_children:   ecs_size_t, /**< Bytes used by ordered children vector. */
	bytes_children_table_map: ecs_size_t, /**< Bytes used by map for non-fragmenting ChildOf table lookups. */
	bytes_reachable_cache:    ecs_size_t, /**< Bytes used by reachable cache. */
}

/** Query memory. */
ecs_query_memory_t :: struct {
	count:          i32,        /**< Number of queries. */
	cached_count:   i32,        /**< Number of queries with caches. */
	bytes_query:    ecs_size_t, /**< Bytes used by ecs_query_impl_t struct. */
	bytes_cache:    ecs_size_t, /**< Bytes used by query cache. */
	bytes_group_by: ecs_size_t, /**< Bytes used by query cache groups (excludes cache elements). */
	bytes_order_by: ecs_size_t, /**< Bytes used by table_slices. */
	bytes_plan:     ecs_size_t, /**< Bytes used by query plan. */
	bytes_terms:    ecs_size_t, /**< Bytes used by terms array. */
	bytes_misc:     ecs_size_t, /**< Bytes used by remaining misc arrays. */
}

/** Table memory histogram constants. */
ECS_TABLE_MEMORY_HISTOGRAM_BUCKET_COUNT :: 14
ECS_TABLE_MEMORY_HISTOGRAM_MAX_COUNT    :: (1<<ECS_TABLE_MEMORY_HISTOGRAM_BUCKET_COUNT)

/** Table memory. */
ecs_table_memory_t :: struct {
	count:               i32,        /**< Total number of tables. */
	empty_count:         i32,        /**< Number of empty tables. */
	column_count:        i32,        /**< Number of table columns. */
	bytes_table:         ecs_size_t, /**< Bytes used by ecs_table_t struct. */
	bytes_type:          ecs_size_t, /**< Bytes used by type, columns, and table records. */
	bytes_entities:      ecs_size_t, /**< Bytes used by entity vectors. */
	bytes_overrides:     ecs_size_t, /**< Bytes used by table overrides. */
	bytes_column_map:    ecs_size_t, /**< Bytes used by column map. */
	bytes_component_map: ecs_size_t, /**< Bytes used by component map. */
	bytes_dirty_state:   ecs_size_t, /**< Bytes used by dirty state. */
	bytes_edges:         ecs_size_t, /**< Bytes used by table graph edges. */
}

/** Table size histogram. */
ecs_table_histogram_t :: struct {
	entity_counts: [14]i32, /**< Entity count histogram buckets. */
}

/** Misc memory. */
ecs_misc_memory_t :: struct {
	bytes_world:                   ecs_size_t, /**< Memory used by world and stages. */
	bytes_observers:               ecs_size_t, /**< Memory used by observers. */
	bytes_systems:                 ecs_size_t, /**< Memory used by systems (excluding system queries). */
	bytes_pipelines:               ecs_size_t, /**< Memory used by pipelines (excluding pipeline queries). */
	bytes_table_lookup:            ecs_size_t, /**< Bytes used for table lookup data structures. */
	bytes_component_record_lookup: ecs_size_t, /**< Bytes used for component record lookup data structures. */
	bytes_locked_components:       ecs_size_t, /**< Locked component map. */
	bytes_type_info:               ecs_size_t, /**< Bytes used for storing type information. */
	bytes_commands:                ecs_size_t, /**< Command queue. */
	bytes_rematch_monitor:         ecs_size_t, /**< Memory used by monitor used to track rematches. */
	bytes_component_ids:           ecs_size_t, /**< Memory used for mapping global to world-local component ids. */
	bytes_reflection:              ecs_size_t, /**< Memory used for component reflection not tracked elsewhere. */
	bytes_tree_spawner:            ecs_size_t, /**< Memory used for tree (prefab) spawners. */
	bytes_prefab_child_indices:    ecs_size_t, /**< Memory used by map that stores indices for ordered prefab children. */
	bytes_stats:                   ecs_size_t, /**< Memory used for statistics tracking not tracked elsewhere. */
	bytes_rest:                    ecs_size_t, /**< Memory used by REST HTTP server. */
}

/** Allocator memory.
* Memory that is allocated by allocators but not in use. */
ecs_allocator_memory_t :: struct {
	bytes_graph_edge:       ecs_size_t, /**< Graph edge allocator. */
	bytes_component_record: ecs_size_t, /**< Component record allocator. */
	bytes_pair_record:      ecs_size_t, /**< Pair record allocator. */
	bytes_table_diff:       ecs_size_t, /**< Table diff allocator. */
	bytes_sparse_chunk:     ecs_size_t, /**< Sparse chunk allocator. */
	bytes_allocator:        ecs_size_t, /**< Generic allocator. */
	bytes_stack_allocator:  ecs_size_t, /**< Stack allocator. */
	bytes_cmd_entry_chunk:  ecs_size_t, /**< Command batching entry chunk allocator. */
	bytes_query_impl:       ecs_size_t, /**< Query struct allocator. */
	bytes_query_cache:      ecs_size_t, /**< Query cache struct allocator. */
	bytes_misc:             ecs_size_t, /**< Miscellaneous allocators. */
}

/** Component with memory statistics. */
EcsWorldMemory :: struct {
	entities:        ecs_entities_memory_t,        /**< Entity memory. */
	components:      ecs_component_memory_t,       /**< Component memory. */
	component_index: ecs_component_index_memory_t, /**< Component index memory. */
	queries:         ecs_query_memory_t,           /**< Query memory. */
	tables:          ecs_table_memory_t,           /**< Table memory. */
	table_histogram: ecs_table_histogram_t,        /**< Table size histogram. */
	misc:            ecs_misc_memory_t,            /**< Miscellaneous memory. */
	allocators:      ecs_allocator_memory_t,       /**< Allocator memory. */
	collection_time: f64,                          /**< Time spent collecting statistics. */
}

@(default_calling_convention="c")
foreign lib {
	/** Get memory usage statistics for the entity index.
	*
	* @param world The world.
	* @return Memory statistics for the entity index.
	*/
	ecs_entity_memory_get :: proc(world: ^ecs_world_t) -> ecs_entities_memory_t ---

	/** Get memory usage statistics for single component record.
	*
	* @param cr The component record.
	* @param result Memory statistics for component record (out).
	*/
	ecs_component_record_memory_get :: proc(cr: ^ecs_component_record_t, result: ^ecs_component_index_memory_t) ---

	/** Get memory usage statistics for the component index.
	*
	* @param world The world.
	* @return Memory statistics for the component index.
	*/
	ecs_component_index_memory_get :: proc(world: ^ecs_world_t) -> ecs_component_index_memory_t ---

	/** Get memory usage statistics for single query.
	*
	* @param query The query.
	* @param result Memory statistics for query (out).
	*/
	ecs_query_memory_get :: proc(query: ^ecs_query_t, result: ^ecs_query_memory_t) ---

	/** Get memory usage statistics for queries.
	*
	* @param world The world.
	* @return Memory statistics for queries.
	*/
	ecs_queries_memory_get :: proc(world: ^ecs_world_t) -> ecs_query_memory_t ---

	/** Get component memory for table.
	*
	* @param table The table.
	* @param result The memory used by components stored in this table (out).
	*/
	ecs_table_component_memory_get :: proc(table: ^ecs_table_t, result: ^ecs_component_memory_t) ---

	/** Get memory usage statistics for components.
	*
	* @param world The world.
	* @return Memory statistics for components.
	*/
	ecs_component_memory_get :: proc(world: ^ecs_world_t) -> ecs_component_memory_t ---

	/** Get memory usage statistics for single table.
	*
	* @param table The table.
	* @param result Memory statistics for table (out).
	*/
	ecs_table_memory_get :: proc(table: ^ecs_table_t, result: ^ecs_table_memory_t) ---

	/** Get memory usage statistics for tables.
	*
	* @param world The world.
	* @return Memory statistics for tables.
	*/
	ecs_tables_memory_get :: proc(world: ^ecs_world_t) -> ecs_table_memory_t ---

	/** Get number of tables by number of entities in the table.
	*
	* @param world The world.
	* @return Number of tables by number of entities in the table.
	*/
	ecs_table_histogram_get :: proc(world: ^ecs_world_t) -> ecs_table_histogram_t ---

	/** Get memory usage statistics for miscellaneous allocations.
	*
	* @param world The world.
	* @return Memory statistics for miscellaneous allocations.
	*/
	ecs_misc_memory_get :: proc(world: ^ecs_world_t) -> ecs_misc_memory_t ---

	/** Get memory usage statistics for allocators.
	*
	* @param world The world.
	* @return Memory statistics for allocators.
	*/
	ecs_allocator_memory_get :: proc(world: ^ecs_world_t) -> ecs_allocator_memory_t ---

	/** Get total memory used by world.
	*
	* @param world The world.
	* @return Total memory used in bytes.
	*/
	ecs_memory_get :: proc(world: ^ecs_world_t) -> ecs_size_t ---

	/** Stats module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsStats)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsStatsImport :: proc(world: ^ecs_world_t) ---
}

/** Component that stores metric value. */
EcsMetricValue :: struct {
	value: f64,
}

/** Component that stores metric source. */
EcsMetricSource :: struct {
	entity: ecs_entity_t,
}

/** Used with ecs_metric_init() to create metric. */
ecs_metric_desc_t :: struct {
	_canary: i32, /**< Used for validity testing. Do not set. */

	/** Entity associated with metric. */
	entity: ecs_entity_t,

	/** Entity associated with member that stores metric value. Must not be set
	* at the same time as id. Cannot be combined with EcsCounterId. */
	member: ecs_entity_t,

	/** Member dot expression. Can be used instead of member and supports nested
	* members. Must be set together with id and should not be set at the same
	* time as member. */
	dotmember: cstring,

	/** Tracks whether entities have the specified component ID. Must not be set
	* at the same time as member. */
	id: ecs_id_t,

	/** If id is a (R, *) wildcard and relationship R has the OneOf property,
	* setting this value to true will track individual targets.
	* If the kind is EcsCounterId and the id is a (R, *) wildcard, this value
	* will create a metric per target. */
	targets: bool,

	/** Must be EcsGauge, EcsCounter, EcsCounterIncrement, or EcsCounterId. */
	kind: ecs_entity_t,

	/** Description of metric. Will only be set if FLECS_DOC addon is enabled. */
	brief: cstring,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new metric.
	* Metrics are entities that store values measured from a range of different
	* properties in the ECS storage. Metrics provide a single unified interface to
	* discovering and reading these values, which can be useful for monitoring
	* utilities, or for debugging.
	*
	* Examples of properties that can be measured by metrics are:
	*  - Component member values
	*  - How long an entity has had a specific component
	*  - How long an entity has had a specific target for a relationship
	*  - How many entities have a specific component
	*
	* Metrics can either be created as a "gauge" or "counter". A gauge is a metric
	* that represents the value of something at a specific point in time, for
	* example "velocity". A counter metric represents a value that is monotonically
	* increasing, for example "miles driven".
	*
	* There are three different counter metric kinds:
	* - EcsCounter
	*   When combined with a member, this will store the actual value of the member
	*   in the metric. This is useful for values that are already counters, such as
	*   a MilesDriven component.
	*   This kind creates a metric per entity that has the member or ID.
	*
	* - EcsCounterIncrement
	*   When combined with a member, this will increment the value of the metric by
	*   the value of the member * delta_time. This is useful for values that are
	*   not counters, such as a Velocity component.
	*   This kind creates a metric per entity that has the member.
	*
	* - EcsCounterId
	*   This metric kind will count the number of entities with a specific
	*   (component) ID. This kind creates a single metric instance for regular IDs,
	*   and a metric instance per target for wildcard IDs when targets is set.
	*
	* @param world The world.
	* @param desc Metric description.
	* @return The metric entity.
	*/
	ecs_metric_init :: proc(world: ^ecs_world_t, desc: ^ecs_metric_desc_t) -> ecs_entity_t ---

	/** Metrics module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsMetrics)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsMetricsImport :: proc(world: ^ecs_world_t) ---
}

/** Maximum number of severity filters per alert. */
ECS_ALERT_MAX_SEVERITY_FILTERS :: (4)

/** Component added to alert instance. */
EcsAlertInstance :: struct {
	message: cstring, /**< Generated alert message. */
}

/** Map with active alerts for entity. */
EcsAlertsActive :: struct {
	info_count:    i32,       /**< Number of alerts for source with info severity. */
	warning_count: i32,       /**< Number of alerts for source with warning severity. */
	error_count:   i32,       /**< Number of alerts for source with error severity. */
	alerts:        ecs_map_t, /**< Map of active alerts for entity. */
}

/** Alert severity filter.
* A severity filter can adjust the severity of an alert based on whether an
* entity in the alert query has a specific component. For example, a filter
* could check if an entity has the "Production" tag, and increase the default
* severity of an alert from Warning to Error.
*/
ecs_alert_severity_filter_t :: struct {
	severity:   ecs_entity_t, /**< Severity kind. */
	with:       ecs_id_t,     /**< Component to match. */
	var:        cstring,      /**< Variable to match component on. Do not include the
                            * '$' character. Leave as NULL for $this. */
	_var_index: i32,          /**< Index of variable in query (do not set). */
}

/** Alert descriptor, used with ecs_alert_init(). */
ecs_alert_desc_t :: struct {
	_canary: i32, /**< Used for validity testing. Do not set. */

	/** Entity associated with alert. */
	entity: ecs_entity_t,

	/** Alert query. An alert will be created for each entity that matches the
	* specified query. The query must have at least one term that uses the
	* $this variable (default). */
	query: ecs_query_desc_t,

	/** Template for alert message. This string is used to generate the alert
	* message and may refer to variables in the query result. The format for
	* the template expressions is as specified by ecs_script_string_interpolate().
	*
	* Examples:
	*
	*     "$this has Position but not Velocity"
	*     "$this has a parent entity $parent without Position"
	*/
	message: cstring,

	/** User-friendly name. Will only be set if FLECS_DOC addon is enabled. */
	doc_name: cstring,

	/** Description of alert. Will only be set if FLECS_DOC addon is enabled. */
	brief: cstring,

	/** Alert severity. Must be EcsAlertInfo, EcsAlertWarning, EcsAlertError, or
	* EcsAlertCritical. Defaults to EcsAlertError. */
	severity: ecs_entity_t,

	/** Severity filters can be used to assign different severities to the same
	* alert. This prevents having to create multiple alerts, and allows
	* entities to transition between severities without resetting the
	* alert duration (optional). */
	severity_filters: [4]ecs_alert_severity_filter_t,

	/** The retain period specifies how long an alert must be inactive before it
	* is cleared. This makes it easier to track noisy alerts. While an alert is
	* inactive, its duration won't increase.
	* When the retain period is 0, the alert will clear immediately after it no
	* longer matches the alert query. */
	retain_period: f32,

	/** Alert when member value is out of range. Uses the warning and error ranges
	* assigned to the member in the MemberRanges component (optional). */
	member: ecs_entity_t,

	/** (Component) ID of member to monitor. If left to 0, this will be set to
	* the parent entity of the member (optional). */
	id: ecs_id_t,

	/** Variable from which to fetch the member (optional). When left to NULL,
	* 'id' will be obtained from $this. */
	var: cstring,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new alert.
	* An alert is a query that is evaluated periodically and creates alert
	* instances for each entity that matches the query. Alerts can be used to
	* automate detection of errors in an application.
	*
	* Alerts are automatically cleared when a query is no longer true for an alert
	* instance. At most one alert instance will be created per matched entity.
	*
	* Alert instances have three components:
	* - AlertInstance: contains the alert message for the instance
	* - MetricSource: contains the entity that triggered the alert
	* - MetricValue: contains how long the alert has been active
	*
	* Alerts reuse components from the metrics addon so that alert instances can be
	* tracked and discovered as metrics. Just like metrics, alert instances are
	* created as children of the alert.
	*
	* When an entity has active alerts, it will have the EcsAlertsActive component
	* which contains a map with active alerts for the entity. This component
	* will be automatically removed once all alerts are cleared for the entity.
	*
	* @param world The world.
	* @param desc Alert description.
	* @return The alert entity.
	*/
	ecs_alert_init :: proc(world: ^ecs_world_t, desc: ^ecs_alert_desc_t) -> ecs_entity_t ---

	/** Return number of active alerts for entity.
	* When a valid alert entity is specified for the alert parameter, the operation
	* will return whether the specified alert is active for the entity. When no
	* alert is specified, the operation will return the total number of active
	* alerts for the entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @param alert The alert to test for (optional).
	* @return The number of active alerts for the entity.
	*/
	ecs_get_alert_count :: proc(world: ^ecs_world_t, entity: ecs_entity_t, alert: ecs_entity_t) -> i32 ---

	/** Return alert instance for specified alert.
	* This operation returns the alert instance for the specified alert. If the
	* alert is not active for the entity, the operation will return 0.
	*
	* @param world The world.
	* @param entity The entity.
	* @param alert The alert to test for.
	* @return The alert instance for the specified alert.
	*/
	ecs_get_alert :: proc(world: ^ecs_world_t, entity: ecs_entity_t, alert: ecs_entity_t) -> ecs_entity_t ---

	/** Alert module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsAlerts)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsAlertsImport :: proc(world: ^ecs_world_t) ---
}

/** Used with ecs_ptr_from_json(), ecs_entity_from_json(). */
ecs_from_json_desc_t :: struct {
	name: cstring, /**< Name of the expression (used for logging). */
	expr: cstring, /**< Full expression (used for logging). */

	/** Callback that allows for specifying a custom lookup function. The
	* default behavior uses ecs_lookup(). */
	lookup_action: proc "c" (_: ^ecs_world_t, value: cstring, ctx: rawptr) -> ecs_entity_t,
	lookup_ctx:    rawptr, /**< Context for lookup_action. */

	/** Require components to be registered with reflection data. When not
	* in strict mode, values for components without reflection are ignored. */
	strict: bool,
}

@(default_calling_convention="c")
foreign lib {
	/** Parse JSON string into value.
	* This operation parses a JSON expression into the provided pointer. The
	* memory pointed to must be large enough to contain a value of the used type.
	*
	* @param world The world.
	* @param type The type of the expression to parse.
	* @param ptr Pointer to the memory to write to.
	* @param json The JSON expression to parse.
	* @param desc Configuration parameters for the deserializer.
	* @return Pointer to the character after the last one read, or NULL if failed.
	*/
	ecs_ptr_from_json :: proc(world: ^ecs_world_t, type: ecs_entity_t, ptr: rawptr, json: cstring, desc: ^ecs_from_json_desc_t) -> cstring ---

	/** Parse JSON object with multiple component values into an entity. The format
	* is the same as the one output by ecs_entity_to_json(), but at the moment
	* only supports the "ids" and "values" members.
	*
	* @param world The world.
	* @param entity The entity to deserialize into.
	* @param json The JSON expression to parse (see entity in JSON format manual).
	* @param desc Configuration parameters for the deserializer.
	* @return Pointer to the character after the last one read, or NULL if failed.
	*/
	ecs_entity_from_json :: proc(world: ^ecs_world_t, entity: ecs_entity_t, json: cstring, desc: ^ecs_from_json_desc_t) -> cstring ---

	/** Parse JSON object with multiple entities into the world. The format is the
	* same as the one output by ecs_world_to_json().
	*
	* @param world The world.
	* @param json The JSON expression to parse (see iterator in JSON format manual).
	* @param desc Deserialization parameters.
	* @return Last deserialized character, NULL if failed.
	*/
	ecs_world_from_json :: proc(world: ^ecs_world_t, json: cstring, desc: ^ecs_from_json_desc_t) -> cstring ---

	/** Same as ecs_world_from_json(), but loads JSON from a file.
	*
	* @param world The world.
	* @param filename The file from which to load the JSON.
	* @param desc Deserialization parameters.
	* @return Last deserialized character, NULL if failed.
	*/
	ecs_world_from_json_file :: proc(world: ^ecs_world_t, filename: cstring, desc: ^ecs_from_json_desc_t) -> cstring ---

	/** Serialize array into JSON string.
	* This operation serializes a value of the provided type to a JSON string. The
	* memory pointed to must be large enough to contain a value of the used type.
	*
	* If count is 0, the function will serialize a single value, not wrapped in
	* array brackets. If count is >= 1, the operation will serialize values to
	* a comma-separated list inside of array brackets.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param count The number of elements to serialize.
	* @return String with JSON expression, or NULL if failed.
	*/
	ecs_array_to_json :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr, count: i32) -> cstring ---

	/** Serialize array into JSON string buffer.
	* Same as ecs_array_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param count The number of elements to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_array_to_json_buf :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr, count: i32, buf_out: ^ecs_strbuf_t) -> i32 ---

	/** Serialize value into JSON string.
	* Same as ecs_array_to_json(), with count = 0.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @return String with JSON expression, or NULL if failed.
	*/
	ecs_ptr_to_json :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr) -> cstring ---

	/** Serialize value into JSON string buffer.
	* Same as ecs_ptr_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_ptr_to_json_buf :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr, buf_out: ^ecs_strbuf_t) -> i32 ---

	/** Serialize type info to JSON.
	* This serializes type information to JSON, and can be used to store or transmit
	* the structure of a (component) value.
	*
	* If the provided type does not have reflection data, "0" will be returned.
	*
	* @param world The world.
	* @param type The type to serialize to JSON.
	* @return A JSON string with the serialized type info, or NULL if failed.
	*/
	ecs_type_info_to_json :: proc(world: ^ecs_world_t, type: ecs_entity_t) -> cstring ---

	/** Serialize type info into JSON string buffer.
	* Same as ecs_type_info_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type to serialize.
	* @param buf_out The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_type_info_to_json_buf :: proc(world: ^ecs_world_t, type: ecs_entity_t, buf_out: ^ecs_strbuf_t) -> i32 ---
}

/** Used with ecs_entity_to_json(). */
ecs_entity_to_json_desc_t :: struct {
	serialize_entity_id:  bool,         /**< Serialize entity ID. */
	serialize_doc:        bool,         /**< Serialize doc attributes. */
	serialize_full_paths: bool,         /**< Serialize full paths for tags, components, and pairs. */
	serialize_inherited:  bool,         /**< Serialize base components. */
	serialize_values:     bool,         /**< Serialize component values. */
	serialize_builtin:    bool,         /**< Serialize built-in data as components (e.g., "name", "parent"). */
	serialize_type_info:  bool,         /**< Serialize type info (requires serialize_values). */
	serialize_alerts:     bool,         /**< Serialize active alerts for the entity. */
	serialize_refs:       ecs_entity_t, /**< Serialize references (incoming edges) for a relationship. */
	serialize_matches:    bool,         /**< Serialize which queries the entity matches with. */

	/** Callback to determine if a component should be serialized. */
	component_filter: proc "c" (^ecs_world_t, ecs_entity_t) -> bool,
}

@(default_calling_convention="c")
foreign lib {
	/** Serialize entity into JSON string.
	* This creates a JSON object with the entity's (path) name, which components
	* and tags the entity has, and the component values.
	*
	* The operation may fail if the entity contains components with invalid values.
	*
	* @param world The world.
	* @param entity The entity to serialize to JSON.
	* @param desc Serialization parameters.
	* @return A JSON string with the serialized entity data, or NULL if failed.
	*/
	ecs_entity_to_json :: proc(world: ^ecs_world_t, entity: ecs_entity_t, desc: ^ecs_entity_to_json_desc_t) -> cstring ---

	/** Serialize entity into JSON string buffer.
	* Same as ecs_entity_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param entity The entity to serialize.
	* @param buf_out The strbuf to append the string to.
	* @param desc Serialization parameters.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_entity_to_json_buf :: proc(world: ^ecs_world_t, entity: ecs_entity_t, buf_out: ^ecs_strbuf_t, desc: ^ecs_entity_to_json_desc_t) -> i32 ---
}

/** Used with ecs_iter_to_json(). */
ecs_iter_to_json_desc_t :: struct {
	serialize_entity_ids:              bool,         /**< Serialize entity IDs. */
	serialize_values:                  bool,         /**< Serialize component values. */
	serialize_builtin:                 bool,         /**< Serialize built-in data as components (e.g., "name", "parent"). */
	serialize_doc:                     bool,         /**< Serialize doc attributes. */
	serialize_full_paths:              bool,         /**< Serialize full paths for tags, components, and pairs. */
	serialize_fields:                  bool,         /**< Serialize field data. */
	serialize_inherited:               bool,         /**< Serialize inherited components. */
	serialize_table:                   bool,         /**< Serialize entire table vs. matched components. */
	serialize_type_info:               bool,         /**< Serialize type information. */
	serialize_field_info:              bool,         /**< Serialize metadata for fields returned by the query. */
	serialize_query_info:              bool,         /**< Serialize query terms. */
	serialize_query_plan:              bool,         /**< Serialize query plan. */
	serialize_query_profile:           bool,         /**< Profile query performance. */
	dont_serialize_results:            bool,         /**< If true, the query will not be evaluated. */
	serialize_alerts:                  bool,         /**< Serialize active alerts for the entity. */
	serialize_refs:                    ecs_entity_t, /**< Serialize references (incoming edges) for a relationship. */
	serialize_matches:                 bool,         /**< Serialize which queries the entity matches with. */
	serialize_parents_before_children: bool,         /**< If the query matches both children and parent, serialize the parent before children. */

	/** Callback to determine if a component should be serialized. */
	component_filter: proc "c" (^ecs_world_t, ecs_entity_t) -> bool,
	query:            ^ecs_poly_t, /**< Query object (required for serialize_query_[plan|profile]). */
}

@(default_calling_convention="c")
foreign lib {
	/** Serialize iterator into JSON string.
	* This operation will iterate the contents of the iterator and serialize them
	* to JSON. The function accepts iterators from any source.
	*
	* @param iter The iterator to serialize to JSON.
	* @param desc Serialization parameters.
	* @return A JSON string with the serialized iterator data, or NULL if failed.
	*/
	ecs_iter_to_json :: proc(iter: ^ecs_iter_t, desc: ^ecs_iter_to_json_desc_t) -> cstring ---

	/** Serialize iterator into JSON string buffer.
	* Same as ecs_iter_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param iter The iterator to serialize.
	* @param buf_out The strbuf to append the string to.
	* @param desc Serialization parameters.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_iter_to_json_buf :: proc(iter: ^ecs_iter_t, buf_out: ^ecs_strbuf_t, desc: ^ecs_iter_to_json_desc_t) -> i32 ---
}

/** Used with ecs_world_to_json(). */
ecs_world_to_json_desc_t :: struct {
	serialize_builtin: bool, /**< Serialize Flecs built-in modules and contents. */
	serialize_modules: bool, /**< Serialize modules and contents. */
}

@(default_calling_convention="c")
foreign lib {
	/** Serialize world into JSON string.
	* This operation serializes the contents of the world to JSON. The operation is
	* equivalent to the following code:
	*
	* @code
	* ecs_query_t *q = ecs_query(world, {
	*   .terms = {{ .id = EcsAny }}
	* });
	*
	* ecs_iter_t it = ecs_query_iter(world, q);
	* ecs_iter_to_json_desc_t desc = { .serialize_table = true };
	* ecs_iter_to_json(&it, &desc);
	* @endcode
	*
	* @param world The world to serialize.
	* @param desc Serialization parameters.
	* @return A JSON string with the serialized iterator data, or NULL if failed.
	*/
	ecs_world_to_json :: proc(world: ^ecs_world_t, desc: ^ecs_world_to_json_desc_t) -> cstring ---

	/** Serialize world into JSON string buffer.
	* Same as ecs_world_to_json(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world to serialize.
	* @param buf_out The strbuf to append the string to.
	* @param desc Serialization parameters.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_world_to_json_buf :: proc(world: ^ecs_world_t, buf_out: ^ecs_strbuf_t, desc: ^ecs_world_to_json_desc_t) -> i32 ---

	/** Units module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsUnits)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsUnitsImport :: proc(world: ^ecs_world_t) ---
}

FLECS_SCRIPT_FUNCTION_ARGS_MAX :: (16)

/* Must be the same as EcsPrimitiveKindLast */
FLECS_SCRIPT_VECTOR_FUNCTION_COUNT :: (18)

ecs_script_template_t :: struct {}

/** Script variable. */
ecs_script_var_t :: struct {
	name:      cstring,          /**< Variable name. */
	value:     ecs_value_t,      /**< Variable value. */
	type_info: ^ecs_type_info_t, /**< Type information. */
	sp:        i32,              /**< Stack pointer. */
	is_const:  bool,             /**< Whether the variable is constant. */
}

/** Script variable scope. */
ecs_script_vars_t :: struct {
	parent:    ^ecs_script_vars_t,  /**< Parent variable scope. */
	sp:        i32,                 /**< Stack pointer for this scope. */
	var_index: ecs_hashmap_t,       /**< Index for variable name lookups. */
	vars:      ecs_vec_t,           /**< Vector of variables in this scope. */
	world:     ^ecs_world_t,        /**< The world. */
	stack:     ^ecs_stack_t,        /**< Stack allocator for variable storage. */
	cursor:    ^ecs_stack_cursor_t, /**< Cursor into the stack allocator. */
	allocator: ^ecs_allocator_t,    /**< General purpose allocator. */
}

/** Script object. */
ecs_script_t :: struct {
	world: ^ecs_world_t, /**< The world. */
	name:  cstring,      /**< Script name. */
	code:  cstring,      /**< Script source code. */
}

ecs_script_runtime_t :: struct {}

/** Script component.
* This component is added to the entities of managed scripts and templates.
*/
EcsScript :: struct {
	filename:  cstring,                /**< Script filename. */
	code:      cstring,                /**< Script source code. */
	error:     cstring,                /**< Set if script evaluation had errors. */
	script:    ^ecs_script_t,          /**< Parsed script object. */
	template_: ^ecs_script_template_t, /**< Only set for template scripts. */
}

/** Script function context. */
ecs_function_ctx_t :: struct {
	world:    ^ecs_world_t, /**< The world. */
	function: ecs_entity_t, /**< The function entity. */
	ctx:      rawptr,       /**< User context. */
}

/** Script function callback. */
ecs_function_callback_t :: proc "c" (ctx: ^ecs_function_ctx_t, argc: i32, argv: ^ecs_value_t, result: ^ecs_value_t)

/** Script vector function callback. */
ecs_vector_function_callback_t :: proc "c" (ctx: ^ecs_function_ctx_t, argc: i32, argv: ^ecs_value_t, result: ^ecs_value_t, elem_count: i32)

/** Function argument type. */
ecs_script_parameter_t :: struct {
	name: cstring,      /**< Parameter name. */
	type: ecs_entity_t, /**< Parameter type. */
}

/** Const component.
* This component describes a const variable that can be used from scripts.
*/
EcsScriptConstVar :: struct {
	value:     ecs_value_t,
	type_info: ^ecs_type_info_t,
}

ecs_script_function_t :: struct {
	return_type:      ecs_entity_t,
	params:           ecs_vec_t, /* vec<ecs_script_parameter_t> */
	callback:         ecs_function_callback_t,
	vector_callbacks: [18]ecs_vector_function_callback_t,
	ctx:              rawptr,
	binding_ctx:      rawptr,
	binding_ctx_free: ecs_ctx_free_t,
}

/** Function component.
* This component describes a function that can be called from a script.
*/
EcsScriptFunction :: ecs_script_function_t

/** Method component.
* This component describes a method that can be called from a script. Methods
* are functions that can be called on instances of a type. A method entity is
* stored in the scope of the type it belongs to.
*/
EcsScriptMethod :: ecs_script_function_t

/** Used with ecs_script_parse() and ecs_script_eval(). */
ecs_script_eval_desc_t :: struct {
	vars:    ^ecs_script_vars_t,    /**< Variables used by script. */
	runtime: ^ecs_script_runtime_t, /**< Reusable runtime (optional). */
}

/** Used to capture error output from script evaluation. */
ecs_script_eval_result_t :: struct {
	error:  cstring, /**< Error message, or NULL if no error. Must be freed by the application. */
	line:   i32,     /**< Line number (1-based) of first error, or 0 if not available. */
	column: i32,     /**< Column number (1-based) of first error, or 0 if not available. */
}

@(default_calling_convention="c")
foreign lib {
	/** Parse script.
	* This operation parses a script and returns a script object upon success. To
	* run the script, call ecs_script_eval().
	*
	* If the script uses outside variables, an ecs_script_vars_t object must be
	* provided in the vars member of the desc object that defines all variables
	* with the correct types.
	*
	* When the result parameter is not NULL, the script will capture errors and
	* return them in the output struct. If result.error is set, it must be freed
	* by the application.
	*
	* @param world The world.
	* @param name Name of the script (typically a file or module name).
	* @param code The script code.
	* @param desc Parameters for script runtime.
	* @param result Output of script evaluation.
	* @return Script object if success, NULL if failed.
	*/
	ecs_script_parse :: proc(world: ^ecs_world_t, name: cstring, code: cstring, desc: ^ecs_script_eval_desc_t, result: ^ecs_script_eval_result_t) -> ^ecs_script_t ---

	/** Evaluate script.
	* This operation evaluates (runs) a parsed script.
	*
	* If variables were provided to ecs_script_parse(), an application may pass
	* a different ecs_script_vars_t object to ecs_script_eval(), as long as the
	* object has all referenced variables and they are of the same type.
	*
	* When the result parameter is not NULL, the script will capture errors and
	* return them in the output struct. If result.error is set, it must be freed
	* by the application.
	*
	* @param script The script.
	* @param desc Parameters for script runtime.
	* @param result Output of script evaluation (optional).
	* @return Zero if success, non-zero if failed.
	*/
	ecs_script_eval :: proc(script: ^ecs_script_t, desc: ^ecs_script_eval_desc_t, result: ^ecs_script_eval_result_t) -> i32 ---

	/** Free script.
	* This operation frees a script object.
	*
	* Templates created by the script rely upon resources in the script object,
	* and for that reason keep the script alive until all templates created by the
	* script are deleted.
	*
	* @param script The script.
	*/
	ecs_script_free :: proc(script: ^ecs_script_t) ---

	/** Parse script.
	* This parses a script and instantiates the entities in the world.
	* This operation is the equivalent to doing:
	*
	* @code
	* ecs_script_t *script = ecs_script_parse(world, name, code);
	* ecs_script_eval(script);
	* ecs_script_free(script);
	* @endcode
	*
	* @param world The world.
	* @param name The script name (typically the file).
	* @param code The script.
	* @param result Output of script evaluation (optional).
	* @return Zero if success, non-zero otherwise.
	*/
	ecs_script_run :: proc(world: ^ecs_world_t, name: cstring, code: cstring, result: ^ecs_script_eval_result_t) -> i32 ---

	/** Parse script file.
	* This parses a script file and instantiates the entities in the world. This
	* operation is equivalent to loading the file contents and passing it to
	* ecs_script_run().
	*
	* @param world The world.
	* @param filename The script file name.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_script_run_file :: proc(world: ^ecs_world_t, filename: cstring) -> i32 ---

	/** Create runtime for script.
	* A script runtime is a container for any data created during script
	* evaluation. By default, calling ecs_script_run() or ecs_script_eval() will
	* create a runtime on the spot. A runtime can be created in advance and reused
	* across multiple script evaluations to improve performance.
	*
	* When scripts are evaluated on multiple threads, each thread should have its
	* own script runtime.
	*
	* A script runtime must be deleted with ecs_script_runtime_free().
	*
	* @return A new script runtime.
	*/
	ecs_script_runtime_new :: proc() -> ^ecs_script_runtime_t ---

	/** Free script runtime.
	* This operation frees a script runtime created by ecs_script_runtime_new().
	*
	* @param runtime The runtime to free.
	*/
	ecs_script_runtime_free :: proc(runtime: ^ecs_script_runtime_t) ---

	/** Convert script AST to string.
	* This operation converts the script abstract syntax tree to a string, which
	* can be used to debug a script.
	*
	* @param script The script.
	* @param buf The buffer to write to.
	* @param colors Whether to include ANSI color codes in the output.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_script_ast_to_buf :: proc(script: ^ecs_script_t, buf: ^ecs_strbuf_t, colors: bool) -> i32 ---

	/** Convert script AST to string.
	* This operation converts the script abstract syntax tree to a string, which
	* can be used to debug a script.
	*
	* @param script The script.
	* @param colors Whether to include ANSI color codes in the output.
	* @return The string if success, NULL if failed.
	*/
	ecs_script_ast_to_str :: proc(script: ^ecs_script_t, colors: bool) -> cstring ---
}

/** Used with ecs_script_init(). */
ecs_script_desc_t :: struct {
	entity:   ecs_entity_t, /**< Set to customize entity handle associated with script. */
	filename: cstring,      /**< Set to load script from file. */
	code:     cstring,      /**< Set to parse script from string. */
}

@(default_calling_convention="c")
foreign lib {
	/** Load managed script.
	* A managed script tracks which entities it creates, and keeps those entities
	* synchronized when the contents of the script are updated. When the script is
	* updated, entities that are no longer in the new version will be deleted.
	*
	* This feature is experimental.
	*
	* @param world The world.
	* @param desc Script descriptor.
	* @return The script entity.
	*/
	ecs_script_init :: proc(world: ^ecs_world_t, desc: ^ecs_script_desc_t) -> ecs_entity_t ---

	/** Update script with new code.
	*
	* @param world The world.
	* @param script The script entity.
	* @param instance A template instance (optional).
	* @param code The script code.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_script_update :: proc(world: ^ecs_world_t, script: ecs_entity_t, instance: ecs_entity_t, code: cstring) -> i32 ---

	/** Clear all entities associated with script.
	*
	* @param world The world.
	* @param script The script entity.
	* @param instance The script instance.
	*/
	ecs_script_clear :: proc(world: ^ecs_world_t, script: ecs_entity_t, instance: ecs_entity_t) ---

	/** Create new variable scope.
	* Create root variable scope. A variable scope contains one or more variables.
	* Scopes can be nested, which allows variables in different scopes to have the
	* same name. Variables from parent scopes will be shadowed by variables in
	* child scopes with the same name.
	*
	* Use the `ecs_script_vars_push()` and `ecs_script_vars_pop()` functions to
	* push and pop variable scopes.
	*
	* When a variable contains allocated resources (e.g., a string), its resources
	* will be freed when `ecs_script_vars_pop()` is called on the scope, the
	* ecs_script_vars_t::type_info field is initialized for the variable, and
	* `ecs_type_info_t::hooks::dtor` is set.
	*
	* @param world The world.
	* @return The new root variable scope.
	*/
	ecs_script_vars_init :: proc(world: ^ecs_world_t) -> ^ecs_script_vars_t ---

	/** Free variable scope.
	* Free root variable scope. The provided scope should not have a parent. This
	* operation calls `ecs_script_vars_pop()` on the scope.
	*
	* @param vars The variable scope.
	*/
	ecs_script_vars_fini :: proc(vars: ^ecs_script_vars_t) ---

	/** Push new variable scope.
	*
	* Scopes created with ecs_script_vars_push() must be cleaned up with
	* ecs_script_vars_pop().
	*
	* If the stack and allocator arguments are left to NULL, their values will be
	* copied from the parent.
	*
	* @param parent The parent scope (provide NULL for root scope).
	* @return The new variable scope.
	*/
	ecs_script_vars_push :: proc(parent: ^ecs_script_vars_t) -> ^ecs_script_vars_t ---

	/** Pop variable scope.
	* This frees up the resources for a variable scope. The scope must be at the
	* top of a vars stack. Calling ecs_script_vars_pop() on a scope that is not the
	* last scope causes undefined behavior.
	*
	* @param vars The scope to free.
	* @return The parent scope.
	*/
	ecs_script_vars_pop :: proc(vars: ^ecs_script_vars_t) -> ^ecs_script_vars_t ---

	/** Declare a variable.
	* This operation declares a new variable in the current scope. If a variable
	* with the specified name already exists, the operation will fail.
	*
	* This operation does not allocate storage for the variable. This is done to
	* allow for variables that point to existing storage, which prevents having
	* to copy existing values to a variable scope.
	*
	* @param vars The variable scope.
	* @param name The variable name.
	* @return The new variable, or NULL if the operation failed.
	*/
	ecs_script_vars_declare :: proc(vars: ^ecs_script_vars_t, name: cstring) -> ^ecs_script_var_t ---

	/** Define a variable.
	* This operation calls `ecs_script_vars_declare()` and allocates storage for
	* the variable. If the type has a ctor, it will be called on the new storage.
	*
	* The scope's stack allocator will be used to allocate the storage. After
	* `ecs_script_vars_pop()` is called on the scope, the variable storage will no
	* longer be valid.
	*
	* The operation will fail if the type argument is not a type.
	*
	* @param vars The variable scope.
	* @param name The variable name.
	* @param type The variable type.
	* @return The new variable, or NULL if the operation failed.
	*/
	ecs_script_vars_define_id :: proc(vars: ^ecs_script_vars_t, name: cstring, type: ecs_entity_t) -> ^ecs_script_var_t ---

	/** Lookup a variable.
	* This operation looks up a variable in the current scope. If the variable
	* can't be found in the current scope, the operation will recursively search
	* the parent scopes.
	*
	* @param vars The variable scope.
	* @param name The variable name.
	* @return The variable, or NULL if one with the provided name does not exist.
	*/
	ecs_script_vars_lookup :: proc(vars: ^ecs_script_vars_t, name: cstring) -> ^ecs_script_var_t ---

	/** Lookup a variable by stack pointer.
	* This operation provides a faster way to lookup variables that are always
	* declared in the same order in a ecs_script_vars_t scope.
	*
	* The stack pointer of a variable can be obtained from the ecs_script_var_t
	* type. The provided frame offset must be valid for the provided variable
	* stack. If the frame offset is not valid, this operation will panic.
	*
	* @param vars The variable scope.
	* @param sp The stack pointer to the variable.
	* @return The variable.
	*/
	ecs_script_vars_from_sp :: proc(vars: ^ecs_script_vars_t, sp: i32) -> ^ecs_script_var_t ---

	/** Print variables.
	* This operation prints all variables in the vars scope and parent scopes.
	*
	* @param vars The variable scope.
	*/
	ecs_script_vars_print :: proc(vars: ^ecs_script_vars_t) ---

	/** Preallocate space for variables.
	* This operation preallocates space for the specified number of variables. This
	* is a performance optimization only, and is not necessary before declaring
	* variables in a scope.
	*
	* @param vars The variable scope.
	* @param count The number of variables to preallocate space for.
	*/
	ecs_script_vars_set_size :: proc(vars: ^ecs_script_vars_t, count: i32) ---

	/** Convert iterator to vars.
	* This operation converts an iterator to a variable array. This allows for
	* using iterator results in expressions. The operation only converts a
	* single result at a time, and does not progress the iterator.
	*
	* Iterator fields with data will be made available as variables with as name
	* the field index (e.g., "$1"). The operation does not check if reflection data
	* is registered for a field type. If no reflection data is registered for the
	* type, using the field variable in expressions will fail.
	*
	* Field variables will only contain single elements, even if the iterator
	* returns component arrays. The offset parameter can be used to specify which
	* element in the component arrays to return. The offset parameter must be
	* smaller than it->count.
	*
	* The operation will create a variable for query variables that contain a
	* single entity.
	*
	* The operation will attempt to use existing variables. If a variable does not
	* yet exist, the operation will create it. If an existing variable exists with
	* a mismatching type, the operation will fail.
	*
	* Accessing variables after progressing the iterator or after the iterator is
	* destroyed will result in undefined behavior.
	*
	* If vars contains a variable that is not present in the iterator, the variable
	* will not be modified.
	*
	* @param it The iterator to convert to variables.
	* @param vars The variables to write to.
	* @param offset The offset to the current element.
	*/
	ecs_script_vars_from_iter :: proc(it: ^ecs_iter_t, vars: ^ecs_script_vars_t, offset: i32) ---
}

/** Used with ecs_expr_run(). */
ecs_expr_eval_desc_t :: struct {
	name:          cstring,                                                                 /**< Script name. */
	expr:          cstring,                                                                 /**< Full expression string. */
	vars:          ^ecs_script_vars_t,                                                      /**< Variables accessible in expression. */
	type:          ecs_entity_t,                                                            /**< Type of parsed value (optional). */
	lookup_action: proc "c" (_: ^ecs_world_t, value: cstring, ctx: rawptr) -> ecs_entity_t, /**< Function for resolving entity identifiers. */
	lookup_ctx:    rawptr,                                                                  /**< Context passed to lookup function. */

	/** Disable constant folding (slower evaluation, faster parsing). */
	disable_folding: bool,

	/** This option instructs the expression runtime to lookup variables by
	* stack pointer instead of by name, which improves performance. Only enable
	* when provided variables are always declared in the same order. */
	disable_dynamic_variable_binding: bool,

	/** Allow for unresolved identifiers when parsing. Useful when entities can
	* be created in between parsing and evaluating. */
	allow_unresolved_identifiers: bool,
	runtime:                      ^ecs_script_runtime_t,                                           /**< Reusable runtime (optional). */
	script_visitor:               rawptr,                                                          /**< For internal usage. */
	unresolved_identifier_action: proc "c" (_: ^ecs_world_t, value: cstring, ctx: rawptr) -> bool, /**< For internal usage. */
}

@(default_calling_convention="c")
foreign lib {
	/** Run expression.
	* This operation runs an expression and stores the result in the provided
	* value. If the value contains a type that is different from the type of the
	* expression, the expression will be cast to the value.
	*
	* If the provided value for value.ptr is NULL, the value must be freed with
	* ecs_value_free() afterwards.
	*
	* @param world The world.
	* @param ptr The pointer to the expression to parse.
	* @param value The value containing type and pointer to write to.
	* @param desc Configuration parameters for the parser.
	* @return Pointer to the character after the last one read, or NULL if failed.
	*/
	ecs_expr_run :: proc(world: ^ecs_world_t, ptr: cstring, value: ^ecs_value_t, desc: ^ecs_expr_eval_desc_t) -> cstring ---

	/** Parse expression.
	* This operation parses an expression and returns an object that can be
	* evaluated multiple times with ecs_expr_eval().
	*
	* @param world The world.
	* @param expr The expression string.
	* @param desc Configuration parameters for the parser.
	* @return A script object if parsing is successful, NULL if parsing failed.
	*/
	ecs_expr_parse :: proc(world: ^ecs_world_t, expr: cstring, desc: ^ecs_expr_eval_desc_t) -> ^ecs_script_t ---

	/** Evaluate expression.
	* This operation evaluates an expression parsed with ecs_expr_parse()
	* and stores the result in the provided value. If the value contains a type
	* that is different from the type of the expression, the expression will be
	* cast to the value.
	*
	* If the provided value for value.ptr is NULL, the value must be freed with
	* ecs_value_free() afterwards.
	*
	* @param script The script containing the expression.
	* @param value The value in which to store the expression result.
	* @param desc Configuration parameters for the parser.
	* @return Zero if successful, non-zero if failed.
	*/
	ecs_expr_eval :: proc(script: ^ecs_script_t, value: ^ecs_value_t, desc: ^ecs_expr_eval_desc_t) -> i32 ---

	/** Evaluate interpolated expressions in string.
	* This operation evaluates expressions in a string, and replaces them with
	* their evaluated result. Supported expression formats are:
	*  - $variable_name
	*  - {expression}
	*
	* The $, { and } characters can be escaped with a backslash (\).
	*
	* @param world The world.
	* @param str The string to evaluate.
	* @param vars The variables to use for evaluation.
	* @return String with interpolated expressions, or NULL if failed.
	*/
	ecs_script_string_interpolate :: proc(world: ^ecs_world_t, str: cstring, vars: ^ecs_script_vars_t) -> cstring ---
}

/** Used with ecs_const_var_init(). */
ecs_const_var_desc_t :: struct {
	/** Variable name. */
	name: cstring,

	/** Variable parent (namespace). */
	parent: ecs_entity_t,

	/** Variable type. */
	type: ecs_entity_t,

	/** Pointer to value of variable. The value will be copied to an internal
	* storage and does not need to be kept alive. */
	value: rawptr,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a const variable that can be accessed by scripts.
	*
	* @param world The world.
	* @param desc Const var parameters.
	* @return The const var, or 0 if failed.
	*/
	ecs_const_var_init :: proc(world: ^ecs_world_t, desc: ^ecs_const_var_desc_t) -> ecs_entity_t ---

	/** Return the value for a const variable.
	* This returns the value for a const variable that is created either with
	* ecs_const_var_init(), or in a script with "export const v: ...".
	*
	* @param world The world.
	* @param var The variable associated with the entity.
	* @return The value of the const variable.
	*/
	ecs_const_var_get :: proc(world: ^ecs_world_t, var: ecs_entity_t) -> ecs_value_t ---
}

/** Vector function callbacks for different element types. */
ecs_vector_fn_callbacks_t :: struct {
	_i8:  ecs_vector_function_callback_t, /**< Callback for i8 element type. */
	_i32: ecs_vector_function_callback_t, /**< Callback for i32 element type. */
}

/** Used with ecs_function_init() and ecs_method_init(). */
ecs_function_desc_t :: struct {
	/** Function name. */
	name: cstring,

	/** Parent of function. For methods the parent is the type for which the
	* method will be registered. */
	parent: ecs_entity_t,

	/** Function parameters. */
	params: [16]ecs_script_parameter_t,

	/** Function return type. */
	return_type: ecs_entity_t,

	/** Function implementation. */
	callback: ecs_function_callback_t,

	/** Vector function implementations.
	* Set these callbacks if a function has one or more arguments of type
	* flecs.script.vector, and optionally a return type of flecs.script.vector.
	*
	* The flecs.script.vector type allows a function to be called with types
	* that meet the following constraints:
	* - The same type is provided for all arguments of type flecs.script.vector
	* - The provided type has one or more members of the same type
	* - The member type must be a primitive type
	* - The vector_callbacks array has an implementation for the primitive type.
	*
	* This allows for statements like:
	* @code
	* const a = Rgb: {100, 150, 250}
	* const b = Rgb: {10, 10, 10}
	* const r = lerp(a, b, 0.1)
	* @endcode
	*
	* which would otherwise have to be written out as:
	*
	* @code
	* const r = Rgb: {
	*   lerp(a.r, b.r, 0.1),
	*   lerp(a.g, b.g, 0.1),
	*   lerp(a.b, b.b, 0.1)
	* }
	* @endcode
	*
	* To register vector functions, do:
	*
	* @code
	* ecs_function(world, {
	*     .name = "lerp",
	*     .return_type = EcsScriptVectorType,
	*     .params = {
	*         { .name = "a", .type = EcsScriptVectorType },
	*         { .name = "b", .type = EcsScriptVectorType },
	*         { .name = "t", .type = ecs_id(ecs_f64_t) }
	*     },
	*     .vector_callbacks = {
	*       [EcsF32] = flecs_lerp32,
	*       [EcsF64] = flecs_lerp64
	*     }
	* });
	* @endcode
	*
	*/
	vector_callbacks: [18]ecs_vector_function_callback_t,

	/** Context passed to function implementation. */
	ctx: rawptr,
}

@(default_calling_convention="c")
foreign lib {
	/** Create new function.
	* This operation creates a new function that can be called from a script.
	*
	* @param world The world.
	* @param desc Function init parameters.
	* @return The function, or 0 if failed.
	*/
	ecs_function_init :: proc(world: ^ecs_world_t, desc: ^ecs_function_desc_t) -> ecs_entity_t ---

	/** Create new method.
	* This operation creates a new method that can be called from a script. A
	* method is like a function, except that it can be called on every instance of
	* a type.
	*
	* Methods automatically receive the instance on which the method is invoked as
	* first argument.
	*
	* @param world The world.
	* @param desc Method init parameters.
	* @return The method, or 0 if failed.
	*/
	ecs_method_init :: proc(world: ^ecs_world_t, desc: ^ecs_function_desc_t) -> ecs_entity_t ---

	/** Serialize value into expression string.
	* This operation serializes a value of the provided type to a string. The
	* memory pointed to must be large enough to contain a value of the used type.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @return String with expression, or NULL if failed.
	*/
	ecs_ptr_to_expr :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr) -> cstring ---

	/** Serialize value into expression buffer.
	* Same as ecs_ptr_to_expr(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param buf The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_ptr_to_expr_buf :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr, buf: ^ecs_strbuf_t) -> i32 ---

	/** Similar to ecs_ptr_to_expr(), but serializes values to string.
	* Whereas the output of ecs_ptr_to_expr() is a valid expression, the output of
	* ecs_ptr_to_str() is a string representation of the value. In most cases the
	* output of the two operations is the same, but there are some differences:
	* - Strings are not quoted
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @return String with result, or NULL if failed.
	*/
	ecs_ptr_to_str :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr) -> cstring ---

	/** Serialize value into string buffer.
	* Same as ecs_ptr_to_str(), but serializes to an ecs_strbuf_t instance.
	*
	* @param world The world.
	* @param type The type of the value to serialize.
	* @param data The value to serialize.
	* @param buf The strbuf to append the string to.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_ptr_to_str_buf :: proc(world: ^ecs_world_t, type: ecs_entity_t, data: rawptr, buf: ^ecs_strbuf_t) -> i32 ---
}

ecs_expr_node_t :: struct {}

@(default_calling_convention="c")
foreign lib {
	/** Script module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsScript)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsScriptImport :: proc(world: ^ecs_world_t) ---
}

/** Component that stores description.
* Used as pair together with the following tags to store entity documentation:
* - EcsName
* - EcsDocBrief
* - EcsDocDetail
* - EcsDocLink
* - EcsDocColor
*/
EcsDocDescription :: struct {
	value: cstring, /**< Description value. */
}

@(default_calling_convention="c")
foreign lib {
	/** Add UUID to entity.
	* Associate entity with an (external) UUID.
	*
	* @param world The world.
	* @param entity The entity to which to add the UUID.
	* @param uuid The UUID to add.
	*
	* @see ecs_doc_get_uuid()
	* @see flecs::doc::set_uuid()
	* @see flecs::entity_builder::set_doc_uuid()
	*/
	ecs_doc_set_uuid :: proc(world: ^ecs_world_t, entity: ecs_entity_t, uuid: cstring) ---

	/** Add human-readable name to entity.
	* Contrary to entity names, human-readable names do not have to be unique and
	* can contain special characters used in the query language like '*'.
	*
	* @param world The world.
	* @param entity The entity to which to add the name.
	* @param name The name to add.
	*
	* @see ecs_doc_get_name()
	* @see flecs::doc::set_name()
	* @see flecs::entity_builder::set_doc_name()
	*/
	ecs_doc_set_name :: proc(world: ^ecs_world_t, entity: ecs_entity_t, name: cstring) ---

	/** Add brief description to entity.
	*
	* @param world The world.
	* @param entity The entity to which to add the description.
	* @param description The description to add.
	*
	* @see ecs_doc_get_brief()
	* @see flecs::doc::set_brief()
	* @see flecs::entity_builder::set_doc_brief()
	*/
	ecs_doc_set_brief :: proc(world: ^ecs_world_t, entity: ecs_entity_t, description: cstring) ---

	/** Add detailed description to entity.
	*
	* @param world The world.
	* @param entity The entity to which to add the description.
	* @param description The description to add.
	*
	* @see ecs_doc_get_detail()
	* @see flecs::doc::set_detail()
	* @see flecs::entity_builder::set_doc_detail()
	*/
	ecs_doc_set_detail :: proc(world: ^ecs_world_t, entity: ecs_entity_t, description: cstring) ---

	/** Add link to external documentation to entity.
	*
	* @param world The world.
	* @param entity The entity to which to add the link.
	* @param link The link to add.
	*
	* @see ecs_doc_get_link()
	* @see flecs::doc::set_link()
	* @see flecs::entity_builder::set_doc_link()
	*/
	ecs_doc_set_link :: proc(world: ^ecs_world_t, entity: ecs_entity_t, link: cstring) ---

	/** Add color to entity.
	* UIs can use color as a hint to improve visualizing entities.
	*
	* @param world The world.
	* @param entity The entity to which to add the color.
	* @param color The color to add.
	*
	* @see ecs_doc_get_color()
	* @see flecs::doc::set_color()
	* @see flecs::entity_builder::set_doc_color()
	*/
	ecs_doc_set_color :: proc(world: ^ecs_world_t, entity: ecs_entity_t, color: cstring) ---

	/** Get UUID from entity.
	* @param world The world.
	* @param entity The entity from which to get the UUID.
	* @return The UUID.
	*
	* @see ecs_doc_set_uuid()
	* @see flecs::doc::get_uuid()
	* @see flecs::entity_view::get_doc_uuid()
	*/
	ecs_doc_get_uuid :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Get human-readable name from entity.
	* If the entity does not have an explicit human-readable name, this operation will
	* return the entity name.
	*
	* To test if an entity has a human-readable name, use:
	*
	* @code
	* ecs_has_pair(world, e, ecs_id(EcsDocDescription), EcsName);
	* @endcode
	*
	* Or in C++:
	*
	* @code
	* e.has<flecs::doc::Description>(flecs::Name);
	* @endcode
	*
	* @param world The world.
	* @param entity The entity from which to get the name.
	* @return The name.
	*
	* @see ecs_doc_set_name()
	* @see flecs::doc::get_name()
	* @see flecs::entity_view::get_doc_name()
	*/
	ecs_doc_get_name :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Get brief description from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the description.
	* @return The description.
	*
	* @see ecs_doc_set_brief()
	* @see flecs::doc::get_brief()
	* @see flecs::entity_view::get_doc_brief()
	*/
	ecs_doc_get_brief :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Get detailed description from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the description.
	* @return The description.
	*
	* @see ecs_doc_set_detail()
	* @see flecs::doc::get_detail()
	* @see flecs::entity_view::get_doc_detail()
	*/
	ecs_doc_get_detail :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Get link to external documentation from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the link.
	* @return The link.
	*
	* @see ecs_doc_set_link()
	* @see flecs::doc::get_link()
	* @see flecs::entity_view::get_doc_link()
	*/
	ecs_doc_get_link :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Get color from entity.
	*
	* @param world The world.
	* @param entity The entity from which to get the color.
	* @return The color.
	*
	* @see ecs_doc_set_color()
	* @see flecs::doc::get_color()
	* @see flecs::entity_view::get_doc_color()
	*/
	ecs_doc_get_color :: proc(world: ^ecs_world_t, entity: ecs_entity_t) -> cstring ---

	/** Doc module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsDoc)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsDocImport :: proc(world: ^ecs_world_t) ---
}

/** Max number of constants and members that can be specified in desc structs. */
ECS_MEMBER_DESC_CACHE_SIZE :: (32)

/** Primitive type definitions.
* These typedefs allow the built-in primitives to be used as regular components:
*
* @code
* ecs_set(world, e, ecs_i32_t, {10});
* @endcode
*
* Or a more useful example (create an enum constant with a manual value):
*
* @code
* ecs_set_pair_second(world, e, EcsConstant, ecs_i32_t, {10});
* @endcode
*/
ecs_bool_t   :: bool        /**< Built-in bool type. */
ecs_char_t   :: i8          /**< Built-in char type. */
ecs_byte_t   :: u8          /**< Built-in ecs_byte type. */
ecs_u8_t     :: u8          /**< Built-in u8 type. */
ecs_u16_t    :: u16         /**< Built-in u16 type. */
ecs_u32_t    :: u32         /**< Built-in u32 type. */
ecs_u64_t    :: u64         /**< Built-in u64 type. */
ecs_uptr_t   :: c.uintptr_t /**< Built-in uptr type. */
ecs_i8_t     :: i8          /**< Built-in i8 type. */
ecs_i16_t    :: i16         /**< Built-in i16 type. */
ecs_i32_t    :: i32         /**< Built-in i32 type. */
ecs_i64_t    :: i64         /**< Built-in i64 type. */
ecs_iptr_t   :: c.intptr_t  /**< Built-in iptr type. */
ecs_f32_t    :: f32         /**< Built-in f32 type. */
ecs_f64_t    :: f64         /**< Built-in f64 type. */
ecs_string_t :: cstring     /**< Built-in string type. */

/** Type kinds supported by meta addon. */
ecs_type_kind_t :: enum i32 {
	PrimitiveType = 0,
	BitmaskType   = 1,
	EnumType      = 2,
	StructType    = 3,
	ArrayType     = 4,
	VectorType    = 5,
	OpaqueType    = 6,
	TypeKindLast  = 6,
}

/** Component that is automatically added to every type with the right kind. */
EcsType :: struct {
	kind:     ecs_type_kind_t, /**< Type kind. */
	existing: bool,            /**< Whether the type existed or was populated from reflection. */
	partial:  bool,            /**< Whether the reflection data is a partial type description. */
}

/** Primitive type kinds supported by meta addon. */
ecs_primitive_kind_t :: enum i32 {
	Bool              = 1,
	Char              = 2,
	Byte              = 3,
	U8                = 4,
	U16               = 5,
	U32               = 6,
	U64               = 7,
	I8                = 8,
	I16               = 9,
	I32               = 10,
	I64               = 11,
	F32               = 12,
	F64               = 13,
	UPtr              = 14,
	IPtr              = 15,
	String            = 16,
	Entity            = 17,
	Id                = 18,
	PrimitiveKindLast = 18,
}

/** Component added to primitive types. */
EcsPrimitive :: struct {
	kind: ecs_primitive_kind_t, /**< Primitive type kind. */
}

/** Component added to member entities. */
EcsMember :: struct {
	type:       ecs_entity_t, /**< Member type. */
	count:      i32,          /**< Number of elements for inline arrays. Leave to 0 for non-array members. */
	unit:       ecs_entity_t, /**< Member unit. */
	offset:     i32,          /**< Member offset. */
	use_offset: bool,         /**< If offset should be explicitly used. */
}

/** Type expressing a range for a member value. */
ecs_member_value_range_t :: struct {
	min: f64, /**< Min member value. */
	max: f64, /**< Max member value. */
}

/** Component added to member entities to express valid value ranges. */
EcsMemberRanges :: struct {
	value:   ecs_member_value_range_t, /**< Member value range. */
	warning: ecs_member_value_range_t, /**< Member value warning range. */
	error:   ecs_member_value_range_t, /**< Member value error range. */
}

/** Element type of members vector in EcsStruct. */
ecs_member_t :: struct {
	/** Must be set when used with ecs_struct_desc_t. */
	name: cstring,

	/** Member type. */
	type: ecs_entity_t,

	/** Element count (for inline arrays). May be set when used with
	* ecs_struct_desc_t. Leave to 0 for non-array members. */
	count: i32,

	/** May be set when used with ecs_struct_desc_t. Member offset. */
	offset: i32,

	/** May be set when used with ecs_struct_desc_t. Will be auto-populated if
	* the type entity is also a unit. */
	unit: ecs_entity_t,

	/** Set to true to prevent automatic offset computation. This option should
	* be used when members are registered out of order or where calculation of
	* member offsets doesn't match C type offsets. */
	use_offset: bool,

	/** Numerical range that specifies which values member can assume. This
	* range may be used by UI elements such as a progress bar or slider. The
	* value of a member should not exceed this range. */
	range: ecs_member_value_range_t,

	/** Numerical range outside of which the value represents an error. This
	* range may be used by UI elements to style a value. */
	error_range: ecs_member_value_range_t,

	/** Numerical range outside of which the value represents a warning. This
	* range may be used by UI elements to style a value. */
	warning_range: ecs_member_value_range_t,

	/** Should not be set by ecs_struct_desc_t. */
	size: ecs_size_t,

	/** Should not be set by ecs_struct_desc_t. */
	member: ecs_entity_t,
}

/** Component added to struct type entities. */
EcsStruct :: struct {
	/** Populated from child entities with Member component. */
	members: ecs_vec_t, /* vector<ecs_member_t> */
}

/** Type that describes an enum constant. */
ecs_enum_constant_t :: struct {
	/** Must be set when used with ecs_enum_desc_t. */
	name: cstring,

	/** May be set when used with ecs_enum_desc_t. */
	value: i64,

	/** For when the underlying type is unsigned. */
	value_unsigned: u64,

	/** Should not be set by ecs_enum_desc_t. */
	constant: ecs_entity_t,
}

/** Component added to enum type entities. */
EcsEnum :: struct {
	underlying_type: ecs_entity_t, /**< Underlying type for enum. */
}

/** Type that describes a bitmask constant. */
ecs_bitmask_constant_t :: struct {
	/** Must be set when used with ecs_bitmask_desc_t. */
	name: cstring,

	/** May be set when used with ecs_bitmask_desc_t. */
	value: ecs_flags64_t,

	/** Keep layout the same with ecs_enum_constant_t. */
	_unused: i64,

	/** Should not be set by ecs_bitmask_desc_t. */
	constant: ecs_entity_t,
}

/** Component added to bitmask type entities. */
EcsBitmask :: struct {
	dummy_: i32, /**< Unused. */
}

/** Component with data structures for looking up enum or bitmask constants. */
EcsConstants :: struct {
	/** Populated from child entities with Constant component. */
	constants: ^ecs_map_t, /**< map<i32_t, ecs_enum_constant_t> */

	/** Stores the constants in registration order. */
	ordered_constants: ecs_vec_t, /**< vector<ecs_enum_constants_t> */
}

/** Component added to array type entities. */
EcsArray :: struct {
	type:  ecs_entity_t, /**< Element type. */
	count: i32,          /**< Number of elements. */
}

/** Component added to vector type entities. */
EcsVector :: struct {
	type: ecs_entity_t, /**< Element type. */
}

/** Serializer interface. */
ecs_serializer_t :: struct {
	/** Serialize value. */
	value: proc "c" (ser: ^ecs_serializer_t, type: ecs_entity_t, value: rawptr /**< Pointer to the value to serialize. */) -> i32,

	/** Serialize member. */
	member: proc "c" (ser: ^ecs_serializer_t, member: cstring /**< Member name. */) -> i32,
	world:  ^ecs_world_t, /**< The world. */
	ctx:    rawptr,       /**< Serializer context. */
}

/** Callback invoked serializing an opaque type. */
ecs_meta_serialize_t :: proc "c" (ser: ^ecs_serializer_t, src: rawptr /**< Pointer to value to serialize. */) -> i32

/** Callback invoked to serialize an opaque struct member. */
ecs_meta_serialize_member_t :: proc "c" (ser: ^ecs_serializer_t, src: rawptr, name: cstring /**< Name of member to serialize. */) -> i32

/** Callback invoked to serialize an opaque vector or array element. */
ecs_meta_serialize_element_t :: proc "c" (ser: ^ecs_serializer_t, src: rawptr, elem: c.size_t /**< Element index to serialize. */) -> i32

/** Opaque type reflection data.
* An opaque type is a type with an unknown layout that can be mapped to a type
* known to the reflection framework. See the opaque type reflection examples.
*/
EcsOpaque :: struct {
	as_type:           ecs_entity_t,                 /**< Type that describes the serialized output. */
	serialize:         ecs_meta_serialize_t,         /**< Serialize action. */
	serialize_member:  ecs_meta_serialize_member_t,  /**< Serialize member action. */
	serialize_element: ecs_meta_serialize_element_t, /**< Serialize element action. */

	/* Deserializer interface
	* Only override the callbacks that are valid for the opaque type. If a
	* deserializer attempts to assign a value type that is not supported by the
	* interface, a conversion error is thrown.
	*/
	
	/** Assign bool value. */
	assign_bool: proc "c" (dst: rawptr, value: bool),

	/** Assign char value. */
	assign_char: proc "c" (dst: rawptr, value: i8),

	/** Assign int value. */
	assign_int: proc "c" (dst: rawptr, value: i64),

	/** Assign unsigned int value. */
	assign_uint: proc "c" (dst: rawptr, value: u64),

	/** Assign float value. */
	assign_float: proc "c" (dst: rawptr, value: f64),

	/** Assign string value. */
	assign_string: proc "c" (dst: rawptr, value: cstring),

	/** Assign entity value. */
	assign_entity: proc "c" (dst: rawptr, world: ^ecs_world_t, entity: ecs_entity_t),

	/** Assign (component) ID value. */
	assign_id: proc "c" (dst: rawptr, world: ^ecs_world_t, id: ecs_id_t),

	/** Assign null value. */
	assign_null: proc "c" (dst: rawptr),

	/** Clear collection elements. */
	clear: proc "c" (dst: rawptr),

	/** Ensure and get collection element. */
	ensure_element: proc "c" (dst: rawptr, elem: c.size_t) -> rawptr,

	/** Ensure and get member. */
	ensure_member: proc "c" (dst: rawptr, member: cstring) -> rawptr,

	/** Return number of elements. */
	count: proc "c" (dst: rawptr) -> c.size_t,

	/** Resize to number of elements. */
	resize: proc "c" (dst: rawptr, count: c.size_t),
}

/** Helper type to describe translation between two units. Note that this
* is not intended as a generic approach to unit conversions (e.g., from Celsius
* to Fahrenheit) but to translate between units that derive from the same base
* (e.g., meters to kilometers).
*
* Note that power is applied to the factor. When describing a translation of
* 1000, either use {factor = 1000, power = 1} or {factor = 1, power = 3}. */
ecs_unit_translation_t :: struct {
	factor: i32, /**< Factor to apply (e.g., "1000", "1000000", "1024"). */
	power:  i32, /**< Power to apply to factor (e.g., "1", "3", "-9"). */
}

/** Component that stores unit data. */
EcsUnit :: struct {
	symbol:      cstring,                /**< Unit symbol. */
	prefix:      ecs_entity_t,           /**< Order of magnitude prefix relative to derived. */
	base:        ecs_entity_t,           /**< Base unit (e.g., "meters"). */
	over:        ecs_entity_t,           /**< Over unit (e.g., "per second"). */
	translation: ecs_unit_translation_t, /**< Translation for derived unit. */
}

/** Component that stores unit prefix data. */
EcsUnitPrefix :: struct {
	symbol:      cstring,                /**< Symbol of prefix (e.g., "K", "M", "Ki"). */
	translation: ecs_unit_translation_t, /**< Translation of prefix. */
}

/** Serializer instruction opcodes.
* The meta type serializer works by generating a flattened array with
* instructions that tell a serializer what kind of fields can be found in a
* type at which offsets.
*/
ecs_meta_op_kind_t :: enum i32 {
	OpPushStruct       = 0,  /**< Push struct. */
	OpPushArray        = 1,  /**< Push array. */
	OpPushVector       = 2,  /**< Push vector. */
	OpPop              = 3,  /**< Pop scope. */
	OpOpaqueStruct     = 4,  /**< Opaque struct. */
	OpOpaqueArray      = 5,  /**< Opaque array. */
	OpOpaqueVector     = 6,  /**< Opaque vector. */
	OpForward          = 7,  /**< Forward to type. Allows for recursive types. */
	OpScope            = 8,  /**< Marks last constant that can open or close a scope. */
	OpOpaqueValue      = 9,  /**< Opaque value. */
	OpEnum             = 10,
	OpBitmask          = 11,
	OpPrimitive        = 12, /**< Marks first constant that's a primitive. */
	OpBool             = 13,
	OpChar             = 14,
	OpByte             = 15,
	OpU8               = 16,
	OpU16              = 17,
	OpU32              = 18,
	OpU64              = 19,
	OpI8               = 20,
	OpI16              = 21,
	OpI32              = 22,
	OpI64              = 23,
	OpF32              = 24,
	OpF64              = 25,
	OpUPtr             = 26,
	OpIPtr             = 27,
	OpString           = 28,
	OpEntity           = 29,
	OpId               = 30,
	MetaTypeOpKindLast = 30,
}

/** Meta type serializer instruction data. */
ecs_meta_op_t :: struct {
	kind:            ecs_meta_op_kind_t, /**< Instruction opcode. */
	underlying_kind: ecs_meta_op_kind_t, /**< Underlying type kind (for enums). */
	offset:          ecs_size_t,         /**< Offset of current field. */
	name:            cstring,            /**< Name of value (only used for struct members). */
	elem_size:       ecs_size_t,         /**< Element size (for PushArray or PushVector) and element count (for PopArray). */
	op_count:        i16,                /**< Number of operations until next field or end. */
	member_index:    i16,                /**< Index of member in struct. */
	type:            ecs_entity_t,       /**< Type entity. */
	type_info:       ^ecs_type_info_t,   /**< Type info. */

	is: struct #raw_union {
		members:   ^ecs_hashmap_t,       /**< string -> member index (structs). */
		constants: ^ecs_map_t,           /**< (u)int -> constant entity (enums and bitmasks). */
		opaque:    ecs_meta_serialize_t, /**< Serialize callback for opaque types. */
	},
}

/** Component that stores the type serializer.
* Added to all types with reflection data. */
EcsTypeSerializer :: struct {
	kind: ecs_type_kind_t, /**< Quick access to type kind (same as EcsType). */
	ops:  ecs_vec_t,       /**< vector<ecs_meta_op_t> */
}

/* Deserializer utilities */

/** Maximum level of type nesting.
* >32 levels of nesting are not sane.
*/
ECS_META_MAX_SCOPE_DEPTH :: (32)

/** Type with information about the currently iterated scope. */
ecs_meta_scope_t :: struct {
	type:             ecs_entity_t,   /**< The type being iterated. */
	ops:              ^ecs_meta_op_t, /**< The type operations (see ecs_meta_op_t). */
	ops_count:        i16,            /**< Number of elements in ops. */
	ops_cur:          i16,            /**< Current element in ops. */
	prev_depth:       i16,            /**< Depth to restore, in case dotmember was used. */
	ptr:              rawptr,         /**< Pointer to ops[0]. */
	opaque:           ^EcsOpaque,     /**< Opaque type interface. */
	members:          ^ecs_hashmap_t, /**< string -> member index. */
	is_collection:    bool,           /**< Whether the scope is iterating elements. */
	is_empty_scope:   bool,           /**< Whether the scope was populated (for vectors). */
	is_moved_scope:   bool,           /**< Whether the scope was moved in (with ecs_meta_elem(), for vectors). */
	elem, elem_count: i32,            /**< Set for collections. */
}

/** Type that enables iterating and populating a value using reflection data. */
ecs_meta_cursor_t :: struct {
	world:              ^ecs_world_t,         /**< The world. */
	scope:              [32]ecs_meta_scope_t, /**< Cursor scope stack. */
	depth:              i16,                  /**< Current scope depth. */
	valid:              bool,                 /**< Whether the cursor points to a valid field. */
	is_primitive_scope: bool,                 /**< If in root scope, this allows for a push for primitive types. */

	/** Custom entity lookup action for overriding default ecs_lookup(). */
	lookup_action: proc "c" (^ecs_world_t, cstring, rawptr) -> ecs_entity_t,
	lookup_ctx:    rawptr, /**< Context for lookup_action. */
}

@(default_calling_convention="c")
foreign lib {
	/** Convert serializer to string.
	*
	* @param world The world.
	* @param type The type to convert.
	* @return The serializer string, or NULL if failed.
	*/
	ecs_meta_serializer_to_str :: proc(world: ^ecs_world_t, type: ecs_entity_t) -> cstring ---

	/** Create meta cursor.
	* A meta cursor allows for walking over, reading, and writing a value without
	* having to know its type at compile time.
	*
	* When a value is assigned through the cursor API, it will get converted to
	* the actual value of the underlying type. This allows the underlying type to
	* change without having to update the serialized data. For example, an integer
	* field can be set by a string, a floating-point value can be set as an integer, etc.
	*
	* @param world The world.
	* @param type The type of the value.
	* @param ptr Pointer to the value.
	* @return A meta cursor for the value.
	*/
	ecs_meta_cursor :: proc(world: ^ecs_world_t, type: ecs_entity_t, ptr: rawptr) -> ecs_meta_cursor_t ---

	/** Get pointer to current field.
	*
	* @param cursor The cursor.
	* @return A pointer to the current field.
	*/
	ecs_meta_get_ptr :: proc(cursor: ^ecs_meta_cursor_t) -> rawptr ---

	/** Move cursor to next field.
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_next :: proc(cursor: ^ecs_meta_cursor_t) -> i32 ---

	/** Move cursor to a field.
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_elem :: proc(cursor: ^ecs_meta_cursor_t, elem: i32) -> i32 ---

	/** Move cursor to member.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_member :: proc(cursor: ^ecs_meta_cursor_t, name: cstring) -> i32 ---

	/** Same as ecs_meta_member(), but doesn't throw an error.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	* @see ecs_meta_member()
	*/
	ecs_meta_try_member :: proc(cursor: ^ecs_meta_cursor_t, name: cstring) -> i32 ---

	/** Move cursor to member.
	* Same as ecs_meta_member(), but with support for "foo.bar" syntax.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	* @see ecs_meta_member()
	*/
	ecs_meta_dotmember :: proc(cursor: ^ecs_meta_cursor_t, name: cstring) -> i32 ---

	/** Same as ecs_meta_dotmember(), but doesn't throw an error.
	*
	* @param cursor The cursor.
	* @param name The name of the member.
	* @return Zero if success, non-zero if failed.
	* @see ecs_meta_dotmember()
	*/
	ecs_meta_try_dotmember :: proc(cursor: ^ecs_meta_cursor_t, name: cstring) -> i32 ---

	/** Push a scope (required and only valid for structs and collections).
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_push :: proc(cursor: ^ecs_meta_cursor_t) -> i32 ---

	/** Pop a struct or collection scope (must follow a push).
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_pop :: proc(cursor: ^ecs_meta_cursor_t) -> i32 ---

	/** Is the current scope a collection?
	*
	* @param cursor The cursor.
	* @return True if current scope is a collection, false if not.
	*/
	ecs_meta_is_collection :: proc(cursor: ^ecs_meta_cursor_t) -> bool ---

	/** Get type of current field.
	*
	* @param cursor The cursor.
	* @return The type of the current field.
	*/
	ecs_meta_get_type :: proc(cursor: ^ecs_meta_cursor_t) -> ecs_entity_t ---

	/** Get unit of current field.
	*
	* @param cursor The cursor.
	* @return The unit of the current field.
	*/
	ecs_meta_get_unit :: proc(cursor: ^ecs_meta_cursor_t) -> ecs_entity_t ---

	/** Get member name of current field.
	*
	* @param cursor The cursor.
	* @return The member name of the current field.
	*/
	ecs_meta_get_member :: proc(cursor: ^ecs_meta_cursor_t) -> cstring ---

	/** Get member entity of current field.
	*
	* @param cursor The cursor.
	* @return The member entity of the current field.
	*/
	ecs_meta_get_member_id :: proc(cursor: ^ecs_meta_cursor_t) -> ecs_entity_t ---

	/** Set field with boolean value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_bool :: proc(cursor: ^ecs_meta_cursor_t, value: bool) -> i32 ---

	/** Set field with char value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_char :: proc(cursor: ^ecs_meta_cursor_t, value: i8) -> i32 ---

	/** Set field with int value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_int :: proc(cursor: ^ecs_meta_cursor_t, value: i64) -> i32 ---

	/** Set field with uint value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_uint :: proc(cursor: ^ecs_meta_cursor_t, value: u64) -> i32 ---

	/** Set field with float value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_float :: proc(cursor: ^ecs_meta_cursor_t, value: f64) -> i32 ---

	/** Set field with string value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_string :: proc(cursor: ^ecs_meta_cursor_t, value: cstring) -> i32 ---

	/** Set field with string literal value (has enclosing "").
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_string_literal :: proc(cursor: ^ecs_meta_cursor_t, value: cstring) -> i32 ---

	/** Set field with entity value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_entity :: proc(cursor: ^ecs_meta_cursor_t, value: ecs_entity_t) -> i32 ---

	/** Set field with (component) ID value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_id :: proc(cursor: ^ecs_meta_cursor_t, value: ecs_id_t) -> i32 ---

	/** Set field with null value.
	*
	* @param cursor The cursor.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_null :: proc(cursor: ^ecs_meta_cursor_t) -> i32 ---

	/** Set field with dynamic value.
	*
	* @param cursor The cursor.
	* @param value The value to set.
	* @return Zero if success, non-zero if failed.
	*/
	ecs_meta_set_value :: proc(cursor: ^ecs_meta_cursor_t, value: ^ecs_value_t) -> i32 ---

	/** Get field value as boolean.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_bool :: proc(cursor: ^ecs_meta_cursor_t) -> bool ---

	/** Get field value as char.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_char :: proc(cursor: ^ecs_meta_cursor_t) -> i8 ---

	/** Get field value as signed integer.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_int :: proc(cursor: ^ecs_meta_cursor_t) -> i64 ---

	/** Get field value as unsigned integer.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_uint :: proc(cursor: ^ecs_meta_cursor_t) -> u64 ---

	/** Get field value as float.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_float :: proc(cursor: ^ecs_meta_cursor_t) -> f64 ---

	/** Get field value as string.
	* This operation does not perform conversions. If the field is not a string,
	* this operation will fail.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_string :: proc(cursor: ^ecs_meta_cursor_t) -> cstring ---

	/** Get field value as entity.
	* This operation does not perform conversions.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_entity :: proc(cursor: ^ecs_meta_cursor_t) -> ecs_entity_t ---

	/** Get field value as (component) ID.
	* This operation can convert from an entity.
	*
	* @param cursor The cursor.
	* @return The value of the current field.
	*/
	ecs_meta_get_id :: proc(cursor: ^ecs_meta_cursor_t) -> ecs_id_t ---

	/** Convert pointer of primitive kind to float.
	*
	* @param type_kind The primitive type kind of the value.
	* @param ptr Pointer to a value of a primitive type.
	* @return The value in floating-point format.
	*/
	ecs_meta_ptr_to_float :: proc(type_kind: ecs_primitive_kind_t, ptr: rawptr) -> f64 ---

	/** Get element count for array or vector operations.
	* The operation must either be EcsOpPushArray or EcsOpPushVector. If the
	* operation is EcsOpPushArray, the provided pointer may be NULL.
	*
	* @param op The serializer operation.
	* @param ptr Pointer to the array or vector value.
	* @return The number of elements.
	*/
	ecs_meta_op_get_elem_count :: proc(op: ^ecs_meta_op_t, ptr: rawptr) -> ecs_size_t ---
}

/** Used with ecs_primitive_init(). */
ecs_primitive_desc_t :: struct {
	entity: ecs_entity_t,         /**< Existing entity to use for type (optional). */
	kind:   ecs_primitive_kind_t, /**< Primitive type kind. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new primitive type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_primitive_init :: proc(world: ^ecs_world_t, desc: ^ecs_primitive_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_enum_init(). */
ecs_enum_desc_t :: struct {
	entity:          ecs_entity_t,            /**< Existing entity to use for type (optional). */
	constants:       [32]ecs_enum_constant_t, /**< Enum constants. */
	underlying_type: ecs_entity_t,            /**< Underlying type for enum. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new enum type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_enum_init :: proc(world: ^ecs_world_t, desc: ^ecs_enum_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_bitmask_init(). */
ecs_bitmask_desc_t :: struct {
	entity:    ecs_entity_t,               /**< Existing entity to use for type (optional). */
	constants: [32]ecs_bitmask_constant_t, /**< Bitmask constants. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new bitmask type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_bitmask_init :: proc(world: ^ecs_world_t, desc: ^ecs_bitmask_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_array_init(). */
ecs_array_desc_t :: struct {
	entity: ecs_entity_t, /**< Existing entity to use for type (optional). */
	type:   ecs_entity_t, /**< Element type. */
	count:  i32,          /**< Number of elements. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new array type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_array_init :: proc(world: ^ecs_world_t, desc: ^ecs_array_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_vector_init(). */
ecs_vector_desc_t :: struct {
	entity: ecs_entity_t, /**< Existing entity to use for type (optional). */
	type:   ecs_entity_t, /**< Element type. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new vector type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_vector_init :: proc(world: ^ecs_world_t, desc: ^ecs_vector_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_struct_init(). */
ecs_struct_desc_t :: struct {
	entity:                 ecs_entity_t,     /**< Existing entity to use for type (optional). */
	members:                [32]ecs_member_t, /**< Struct members. */
	create_member_entities: bool,             /**< Create entities for members. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new struct type.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_struct_init :: proc(world: ^ecs_world_t, desc: ^ecs_struct_desc_t) -> ecs_entity_t ---

	/** Add member to struct.
	* This operation adds a member to a struct type. If the provided entity is not
	* a struct type, this operation will add the Struct component.
	*
	* @param world The world.
	* @param type The struct type.
	* @param member The member data.
	*/
	ecs_struct_add_member :: proc(world: ^ecs_world_t, type: ecs_entity_t, member: ^ecs_member_t) -> i32 ---

	/** Get member by name from struct.
	*
	* @param world The world.
	* @param type The struct type.
	* @param name The member name.
	* @return The member if found, or NULL if no member with the provided name exists.
	*/
	ecs_struct_get_member :: proc(world: ^ecs_world_t, type: ecs_entity_t, name: cstring) -> ^ecs_member_t ---

	/** Get member by index from struct.
	*
	* @param world The world.
	* @param type The struct type.
	* @param i The member index.
	* @return The member if found, or NULL if index is larger than the number of members for the struct.
	*/
	ecs_struct_get_nth_member :: proc(world: ^ecs_world_t, type: ecs_entity_t, i: i32) -> ^ecs_member_t ---
}

/** Used with ecs_opaque_init(). */
ecs_opaque_desc_t :: struct {
	entity: ecs_entity_t, /**< Existing entity to use for type (optional). */
	type:   EcsOpaque,    /**< Type that the opaque type maps to. */
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new opaque type.
	* Opaque types are types of which the layout doesn't match what can be modelled
	* with the primitives of the meta framework, but which have a structure
	* that can be described with meta primitives. Typical examples are STL types
	* such as std::string or std::vector, types with a non-trivial layout, and types
	* that only expose getter and setter methods.
	*
	* An opaque type is a combination of a serialization function, and a handle to
	* a meta type which describes the structure of the serialized output. For
	* example, an opaque type for std::string would have a serializer function that
	* accesses .c_str(), and with type ecs_string_t.
	*
	* The serializer callback accepts a serializer object and a pointer to the
	* value of the opaque type to be serialized. The serializer has two methods:
	*
	* - value, which serializes a value (such as .c_str())
	* - member, which specifies a member to be serialized (in the case of a struct)
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new type, 0 if failed.
	*/
	ecs_opaque_init :: proc(world: ^ecs_world_t, desc: ^ecs_opaque_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_unit_init(). */
ecs_unit_desc_t :: struct {
	/** Existing entity to associate with unit (optional). */
	entity: ecs_entity_t,

	/** Unit symbol, e.g., "m", "%", "g". (optional). */
	symbol: cstring,

	/** Unit quantity, e.g., distance, percentage, weight. (optional). */
	quantity: ecs_entity_t,

	/** Base unit, e.g., "meters" (optional). */
	base: ecs_entity_t,

	/** Over unit, e.g., "per second" (optional). */
	over: ecs_entity_t,

	/** Translation to apply to derived unit (optional). */
	translation: ecs_unit_translation_t,

	/** Prefix indicating order of magnitude relative to the derived unit. If set
	* together with "translation", the values must match. If translation is not
	* set, setting prefix will auto-populate it.
	* Additionally, setting the prefix will enforce that the symbol (if set)
	* is consistent with the prefix symbol + symbol of the derived unit. If the
	* symbol is not set, it will be auto-populated. */
	prefix: ecs_entity_t,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new unit.
	*
	* @param world The world.
	* @param desc The unit descriptor.
	* @return The new unit, 0 if failed.
	*/
	ecs_unit_init :: proc(world: ^ecs_world_t, desc: ^ecs_unit_desc_t) -> ecs_entity_t ---
}

/** Used with ecs_unit_prefix_init(). */
ecs_unit_prefix_desc_t :: struct {
	/** Existing entity to associate with unit prefix (optional). */
	entity: ecs_entity_t,

	/** Unit prefix symbol, e.g., "K", "M", "Ki". (optional). */
	symbol: cstring,

	/** Translation to apply to derived unit (optional). */
	translation: ecs_unit_translation_t,
}

@(default_calling_convention="c")
foreign lib {
	/** Create a new unit prefix.
	*
	* @param world The world.
	* @param desc The type descriptor.
	* @return The new unit prefix, 0 if failed.
	*/
	ecs_unit_prefix_init :: proc(world: ^ecs_world_t, desc: ^ecs_unit_prefix_desc_t) -> ecs_entity_t ---

	/** Create a new quantity.
	*
	* @param world The world.
	* @param desc The quantity descriptor.
	* @return The new quantity, 0 if failed.
	*/
	ecs_quantity_init :: proc(world: ^ecs_world_t, desc: ^ecs_entity_desc_t) -> ecs_entity_t ---

	/** Meta module import function.
	* Usage:
	* @code
	* ECS_IMPORT(world, FlecsMeta)
	* @endcode
	*
	* @param world The world.
	*/
	FlecsMetaImport :: proc(world: ^ecs_world_t) ---

	/** Populate meta information from type descriptor. */
	ecs_meta_from_desc :: proc(world: ^ecs_world_t, component: ecs_entity_t, kind: ecs_type_kind_t, desc: cstring) -> i32 ---

	/** Set default OS API implementation.
	* This initializes the OS API with a default implementation for the current
	* platform.
	*/
	ecs_set_os_api_impl :: proc() ---

	/** Import a module.
	* This operation will load a module. The module name will be used to verify
	* whether the module was already loaded, in which case it won't be reimported.
	* The name will be translated from PascalCase to an entity path (pascal.case)
	* before the lookup occurs.
	*
	* Module contents will be stored as children of the module entity. This
	* prevents modules from accidentally defining conflicting identifiers. This is
	* enforced by setting the scope before and after loading the module to the
	* module entity ID.
	*
	* A more convenient way to import a module is by using the ECS_IMPORT macro.
	*
	* @param world The world.
	* @param module The module import function.
	* @param module_name The name of the module.
	* @return The module entity.
	*/
	ecs_import :: proc(world: ^ecs_world_t, module: ecs_module_action_t, module_name: cstring) -> ecs_entity_t ---

	/** Same as ecs_import(), but with name to scope conversion.
	* PascalCase names are automatically converted to scoped names.
	*
	* @param world The world.
	* @param module The module import function.
	* @param module_name_c The name of the module.
	* @return The module entity.
	*/
	ecs_import_c :: proc(world: ^ecs_world_t, module: ecs_module_action_t, module_name_c: cstring) -> ecs_entity_t ---

	/** Import a module from a library.
	* Similar to ecs_import(), except that this operation will attempt to load the
	* module from a dynamic library.
	*
	* A library may contain multiple modules, which is why both a library name and
	* a module name need to be provided. If only a library name is provided, the
	* library name will be reused for the module name.
	*
	* The library will be looked up using a canonical name, which is in the same
	* form as a module, like `flecs.components.transform`. To transform this
	* identifier to a platform-specific library name, the operation relies on the
	* module_to_dl callback of the os_api, which the application has to override if
	* the default does not yield the correct library name.
	*
	* @param world The world.
	* @param library_name The name of the library to load.
	* @param module_name The name of the module to load.
	* @return The module entity.
	*/
	ecs_import_from_library :: proc(world: ^ecs_world_t, library_name: cstring, module_name: cstring) -> ecs_entity_t ---

	/** Register a new module.
	*
	* @param world The world.
	* @param c_name The name of the module.
	* @param desc The component descriptor for the module component.
	* @return The module entity.
	*/
	ecs_module_init :: proc(world: ^ecs_world_t, c_name: cstring, desc: ^ecs_component_desc_t) -> ecs_entity_t ---

	/** Get type name from compiler-generated function name.
	*
	* @param type_name Buffer to write the type name to.
	* @param func_name The compiler-generated function name.
	* @param len The length of the type name.
	* @param front_len The number of characters to skip at the front.
	* @return The type name.
	*/
	ecs_cpp_get_type_name :: proc(type_name: cstring, func_name: cstring, len: c.size_t, front_len: c.size_t) -> cstring ---

	/** Get symbol name from type name.
	*
	* @param symbol_name Buffer to write the symbol name to.
	* @param type_name The type name.
	* @param len The length of the type name.
	* @return The symbol name.
	*/
	ecs_cpp_get_symbol_name :: proc(symbol_name: cstring, type_name: cstring, len: c.size_t) -> cstring ---

	/** Get constant name from compiler-generated function name.
	*
	* @param constant_name Buffer to write the constant name to.
	* @param func_name The compiler-generated function name.
	* @param len The length of the constant name.
	* @param back_len The number of characters to skip at the back.
	* @return The constant name.
	*/
	ecs_cpp_get_constant_name :: proc(constant_name: cstring, func_name: cstring, len: c.size_t, back_len: c.size_t) -> cstring ---

	/** Trim module prefix from type name.
	*
	* @param world The world.
	* @param type_name The type name to trim.
	* @return The trimmed type name.
	*/
	ecs_cpp_trim_module :: proc(world: ^ecs_world_t, type_name: cstring) -> cstring ---
}

ecs_cpp_type_action_t :: proc "c" (world: ^ecs_world_t, component: ecs_entity_t)

ecs_cpp_component_desc_t :: struct {
	id:                    ecs_entity_t,
	ids_index:             i32,
	name:                  cstring,
	cpp_name:              cstring,
	cpp_symbol:            cstring,
	size:                  c.size_t,
	alignment:             c.size_t,
	lifecycle_action:      ecs_cpp_type_action_t,
	enum_action:           ecs_cpp_type_action_t,
	is_component:          bool,
	explicit_registration: bool,
}

@(default_calling_convention="c")
foreign lib {
	/** Register a C++ component.
	*
	* @param world The world.
	* @param desc Component registration parameters.
	*/
	ecs_cpp_component_register :: proc(world: ^ecs_world_t, desc: ^ecs_cpp_component_desc_t) -> ecs_entity_t ---

	/** Initialize a C++ enum type.
	*
	* @param world The world.
	* @param id The entity ID for the enum type.
	* @param underlying_type The underlying integer type of the enum.
	*/
	ecs_cpp_enum_init :: proc(world: ^ecs_world_t, id: ecs_entity_t, underlying_type: ecs_entity_t) ---

	/** Register a C++ enum constant.
	*
	* @param world The world.
	* @param parent The parent enum type entity.
	* @param id The entity ID for the constant.
	* @param name The constant name.
	* @param value Pointer to the constant value.
	* @param value_type The type of the constant value.
	* @param value_size The size of the constant value.
	* @return The constant entity.
	*/
	ecs_cpp_enum_constant_register :: proc(world: ^ecs_world_t, parent: ecs_entity_t, id: ecs_entity_t, name: cstring, value: rawptr, value_type: ecs_entity_t, value_size: c.size_t) -> ecs_entity_t ---
}

/** Result type for C++ set/assign operations. */
ecs_cpp_get_mut_t :: struct {
	world:         ^ecs_world_t, /**< The world. */
	stage:         ^ecs_stage_t, /**< The stage. */
	ptr:           rawptr,       /**< Pointer to the component data. */
	call_modified: bool,         /**< Whether modified should be called. */
}

@(default_calling_convention="c")
foreign lib {
	/** Set a component value for a C++ entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component ID.
	* @param new_ptr Pointer to the new component value.
	* @param size The size of the component.
	* @return Result containing the component pointer and metadata.
	*/
	ecs_cpp_set :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t, new_ptr: rawptr, size: c.size_t) -> ecs_cpp_get_mut_t ---

	/** Assign a component value for a C++ entity.
	*
	* @param world The world.
	* @param entity The entity.
	* @param component The component ID.
	* @param new_ptr Pointer to the new component value.
	* @param size The size of the component.
	* @return Result containing the component pointer and metadata.
	*/
	ecs_cpp_assign :: proc(world: ^ecs_world_t, entity: ecs_entity_t, component: ecs_id_t, new_ptr: rawptr, size: c.size_t) -> ecs_cpp_get_mut_t ---

	/** Create a new entity from C++.
	*
	* @param world The world.
	* @param parent The parent entity.
	* @param name The entity name.
	* @param sep The path separator.
	* @param root_sep The root path separator.
	* @return The new entity.
	*/
	ecs_cpp_new :: proc(world: ^ecs_world_t, parent: ecs_entity_t, name: cstring, sep: cstring, root_sep: cstring) -> ecs_entity_t ---

	/** Get the last registered member for a type.
	*
	* @param world The world.
	* @param type The type entity.
	* @return Pointer to the last member, or NULL if none.
	*/
	ecs_cpp_last_member :: proc(world: ^ecs_world_t, type: ecs_entity_t) -> ^ecs_member_t ---
}

