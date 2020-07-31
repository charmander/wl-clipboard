/* w-scissor
 *
 * Copyright © 2019 Sergey Bugaev <bugaevc@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef TYPES_SEAT_H
#define TYPES_SEAT_H

#include <stdint.h>

struct keyboard;

struct seat {
    /* This field is initialized by the creator */
    struct wl_seat *proxy;

    /* These fields are initialized by the implementation */
    char *name;
    uint32_t capabilities;
};

void seat_init(struct seat *self);
struct keyboard *seat_get_keyboard(struct seat *self);


#endif /* TYPES_SEAT_H */
