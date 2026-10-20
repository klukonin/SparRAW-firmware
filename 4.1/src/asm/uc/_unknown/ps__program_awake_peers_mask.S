/* ps__program_awake_peers_mask @ 0x92fff0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps__notify_awake_peers
 * Зовёт сам: set_reg_886f84_x3
 */
	.section .text.ps__program_awake_peers_mask,"ax",@progbits
	.global ps__program_awake_peers_mask
ps__program_awake_peers_mask:
	.global L_92fff0
L_92fff0:
	st.a r13,[sp,-0x1c]
L_92fff4:
	st blink,[sp, 0x4]
L_92fff8:
	st_s r14,[sp,0x8]
L_92fffa:
	st_s r15,[sp,0xc]
L_92fffc:
	st r17,[sp, 0x14]
L_930000:
	st r18,[sp, 0x18]
L_930004:
	mov r6,0x887000
L_93000c:
	ld r17,[r6, -0x3c]
L_930010:
	ld.as r18,[r6,-0xa7]
L_930014:
	mov_s r14,r0
L_930016:
	extw r18,r18
L_93001a:
	mov_s r15,0x857200
L_930020:
	ldb r4,[r15, 0x6d]
L_930024:
	asl r18,r18,0xa
L_930028:
	st r16,[sp, 0x10]
L_93002c:
	brlt.d r4,0x1,L_93007c
L_930030:
	mov r13,0x0
L_930034:
	mov r16,0x857000
	.global L_93003c
L_93003c:
	ldb_s r3,[r14]
L_93003e:
	add2 r5,r16,r13
L_930042:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_930044:
	stb_s r3,[r14]
L_930046:
	ld.as r0,[r5,0x9f]
L_93004a:
	bmsk r4,r3,0x4
L_93004e:
	add_s r0,r0,r17
L_930050:
	ld.as r1,[r5,0xa2]
L_930054:
	add_s r0,r0,r18
L_930056:
	add_s r1,r1,r0
L_930058:
	ld.as r2,[r5,0x9c]
L_93005c:
	asl r4,r4,0x15
L_930060:
	or r2,r2,r4
L_930064:
	bmsk_s r3,r3,0x2
L_930066:
	asl_s r3,r3,0xa
L_930068:
	bl.d L_926cd0
L_93006c:
	or r2,r2,r3
L_930070:
	ldb r5,[r15, 0x6d]
L_930074:
	add r13,r13,0x1
L_930078:
	brlt r13,r5,L_93003c
	.global L_93007c
L_93007c:
	ld blink,[sp, 0x4]
L_930080:
	ld_s r14,[sp,0x8]
L_930082:
	ld_s r15,[sp,0xc]
L_930084:
	ld r16,[sp, 0x10]
L_930088:
	ld r17,[sp, 0x14]
L_93008c:
	ld r18,[sp, 0x18]
L_930090:
	j.d [blink]
L_930094:
	ld.ab r13,[sp,0x1c]
