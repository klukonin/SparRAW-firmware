/* hwd_mac__set_prio_map_by_mode @ 0x8ce1e4, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac.c
 * Зовут его: hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_mac__set_prio_map_by_mode,"ax",@progbits
	.global hwd_mac__set_prio_map_by_mode
hwd_mac__set_prio_map_by_mode:
	.global L_8ce1e4
L_8ce1e4:
	push_s blink
L_8ce1e6:
	push_s r13
L_8ce1e8:
	brhs.d r0,0x5,L_8ce200
L_8ce1ec:
	mov_s r13,r0
L_8ce1ee:
	ldb.x r10,[0x8033bc,r13]
L_8ce1f6:
	add r0,pcl,0xc
L_8ce1fa:
	add1 r0,r0,r10
L_8ce1fe:
	j_s [r0]
	.global L_8ce200
L_8ce200:
	mov_s r0,blink
L_8ce202:
	mov_s r2,0x1019e38
L_8ce208:
	mov_s r1,0x12db
L_8ce20e:
	bl.d L_8c82c0
L_8ce212:
	mov_s r3,0x85
L_8ce214:
	asl_s r1,r13,0x4
L_8ce216:
	or_s r1,r1,r13
L_8ce218:
	asl r0,r13,0x8
L_8ce21c:
	or_s r0,r0,r1
L_8ce21e:
	asl r1,r13,0xc
L_8ce222:
	or_s r1,r1,r0
L_8ce224:
	asl r0,r13,0x10
L_8ce228:
	or_s r0,r0,r1
L_8ce22a:
	asl r1,r13,0x14
L_8ce22e:
	or_s r1,r1,r0
L_8ce230:
	asl r0,r13,0x18
L_8ce234:
	or_s r0,r0,r1
L_8ce236:
	asl_s r13,r13,0x1c
L_8ce238:
	or_s r0,r0,r13
L_8ce23a:
	mov_s r1,0x886000
L_8ce240:
	st r0,[r1, 0xfc]
L_8ce244:
	mov_s r2,0x886100
L_8ce24a:
	st_s r0,[r2]
L_8ce24c:
	bmsk r1,r0,0x13
L_8ce250:
	st_s r1,[r2,0x4]
L_8ce252:
	st_s r0,[r2,0x8]
L_8ce254:
	st_s r0,[r2,0xc]
L_8ce256:
	bmsk_s r0,r0,0x17
L_8ce258:
	st_s r0,[r2,0x10]
L_8ce25a:
	b L_8c033c
L_8ce25e:
	nop_s
