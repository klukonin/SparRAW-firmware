/* lmac_if__send_init_cfg @ 0x8ec070, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: bf_w_s6_w26, lmac_if__send_init_cfg_cmd
 */
	.section .text.lmac_if__send_init_cfg,"ax",@progbits
	.global lmac_if__send_init_cfg
lmac_if__send_init_cfg:
	.global L_8ec070
L_8ec070:
	push_s blink
L_8ec072:
	mov_s r0,0x4
L_8ec074:
	stb.a r0,[sp,-0x24]
L_8ec078:
	mov_s r0,0x1
L_8ec07a:
	stb r0,[sp, 0x1]
L_8ec07e:
	mov_s r0,0x96
L_8ec080:
	stb r0,[sp, 0x2]
L_8ec084:
	mov_s r1,0x0
L_8ec086:
	stb r1,[sp, 0x3]
L_8ec08a:
	mov_s r0,0xa1
L_8ec08c:
	stb_s r0,[sp,0x4]
L_8ec08e:
	stb r1,[sp, 0x5]
L_8ec092:
	mov_s r0,0x7b
L_8ec094:
	stb r0,[sp, 0x6]
L_8ec098:
	stb r1,[sp, 0x7]
L_8ec09c:
	mov_s r0,0x16
L_8ec09e:
	stb_s r0,[sp,0x8]
L_8ec0a0:
	stb r1,[sp, 0x9]
L_8ec0a4:
	mov_s r0,0x12
L_8ec0a6:
	stb r0,[sp, 0xa]
L_8ec0aa:
	stb r1,[sp, 0xb]
L_8ec0ae:
	mov_s r0,0x60
L_8ec0b0:
	stb_s r0,[sp,0xc]
L_8ec0b2:
	stb r1,[sp, 0xd]
L_8ec0b6:
	mov_s r0,0x6a
L_8ec0b8:
	stb r0,[sp, 0x12]
L_8ec0bc:
	stb r1,[sp, 0x13]
L_8ec0c0:
	mov_s r0,0x91
L_8ec0c2:
	stb r0,[sp, 0xe]
L_8ec0c6:
	mov_s r1,0x2
L_8ec0c8:
	mov_s r0,0xa
L_8ec0ca:
	stb_s r0,[sp,0x10]
L_8ec0cc:
	ld_s r0,[sp,0x14]
L_8ec0ce:
	stb r1,[sp, 0x11]
L_8ec0d2:
	or r0,r0,0xf
L_8ec0d6:
	st_s r0,[sp,0x14]
L_8ec0d8:
	ld_s r0,[sp,0x18]
L_8ec0da:
	stb r1,[sp, 0xf]
L_8ec0de:
	or r0,r0,0x3f
L_8ec0e2:
	st_s r0,[sp,0x18]
L_8ec0e4:
	ld_s r0,[sp,0x1c]
L_8ec0e6:
	mov_s r1,0x0
L_8ec0e8:
	bic r0,r0,0xf
L_8ec0ec:
	bset_s r0,r0,0x3
L_8ec0ee:
	st_s r0,[sp,0x1c]
L_8ec0f0:
	ld_s r0,[sp,0x20]
L_8ec0f2:
	bic r0,r0,0xf
L_8ec0f6:
	or r0,r0,0x38
L_8ec0fa:
	st_s r0,[sp,0x20]
L_8ec0fc:
	add_s r0,sp,0x20
L_8ec0fe:
	bl.d L_8e8528
L_8ec102:
	mov_s r2,0xa
L_8ec104:
	mov_s r0,sp
L_8ec106:
	bl.d L_8d8550
L_8ec10a:
	mov r1,0x1ef
L_8ec10e:
	add_s sp,sp,0x24
L_8ec110:
	pop_s blink
L_8ec112:
	j_s [blink]
