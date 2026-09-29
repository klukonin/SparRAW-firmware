/* mac_bringup__prog_881000 @ 0x8ec114, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.mac_bringup__prog_881000,"ax",@progbits
	.global mac_bringup__prog_881000
mac_bringup__prog_881000:
	.global L_8ec114
L_8ec114:
	push_s blink
L_8ec116:
	mov_s r1,0x3
L_8ec118:
	mov_s r0,0x881000
L_8ec11e:
	st_s r1,[r0,0x2c]
L_8ec120:
	sync
L_8ec124:
	mov_s r1,0x1
L_8ec126:
	mov_s r0,0x881100
L_8ec12c:
	st_s r1,[r0,0x44]
L_8ec12e:
	sync
L_8ec132:
	mov_s r1,0x1
L_8ec134:
	mov_s r0,0x881100
L_8ec13a:
	st_s r1,[r0,0x54]
L_8ec13c:
	sync
L_8ec140:
	mov_s r1,0x1
L_8ec142:
	mov_s r0,0x881100
L_8ec148:
	st_s r1,[r0,0x4c]
L_8ec14a:
	sync
L_8ec14e:
	mov_s r1,0x1
L_8ec150:
	mov_s r0,0x881100
L_8ec156:
	st_s r1,[r0,0x60]
L_8ec158:
	sync
L_8ec15c:
	mov_s r1,0x1
L_8ec15e:
	mov_s r0,0x881100
L_8ec164:
	st_s r1,[r0,0x70]
L_8ec166:
	sync
L_8ec16a:
	mov_s r1,0x1
L_8ec16c:
	mov_s r0,0x881100
L_8ec172:
	st_s r1,[r0,0x68]
L_8ec174:
	sync
L_8ec178:
	mov_s r1,0x5
L_8ec17a:
	mov_s r0,0x881280
L_8ec180:
	st_s r1,[r0,0xc]
L_8ec182:
	st_s r1,[r0,0x14]
L_8ec184:
	st_s r1,[r0,0x1c]
L_8ec186:
	st_s r1,[r0,0x28]
L_8ec188:
	st_s r1,[r0,0x30]
L_8ec18a:
	st_s r1,[r0,0x38]
L_8ec18c:
	pop_s blink
L_8ec18e:
	j_s [blink]
