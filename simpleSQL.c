#include <sqlite3ext.h>
static const sqlite3_api_routines *sqlite3_api;

void
dummy(sqlite3_context *context, int argc, sqlite3_value **argv)
{
    sqlite3_result_int(context, 1);
}
