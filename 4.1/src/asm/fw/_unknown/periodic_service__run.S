/* periodic_service__run @ 0x8cb600, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_detector__arm
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_read_timer, mac_read_tsf64, periodic_service__tick
 */
	.section .text.periodic_service__run,"ax",@progbits
	.global periodic_service__run
periodic_service__run:
	.global L_8cb600
L_8cb600:
	push_s blink
L_8cb602:
	bl L_8c02bc
L_8cb606:
	bl.d L_8e4694
L_8cb60a:
	mov_s r13,r0
L_8cb60c:
	mov_s r15,r0
L_8cb60e:
	ld_s r0,[r13,0x28]
L_8cb610:
	brne_s r0,0,L_8cb664
L_8cb612:
	add r14,r13,0x20
L_8cb616:
	ldb_s r0,[r14,0x4]
L_8cb618:
	cmp r0,0xfe
L_8cb61c:
	mov.ge r0,0x0
L_8cb620:
	bge_s L_8cb626
L_8cb622:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb624:
	extb_s r0,r0
	.global L_8cb626
L_8cb626:
	stb_s r0,[r14,0x4]
L_8cb628:
	ld_s r0,[r13,0x14]
L_8cb62a:
	mov r16,-0x1
L_8cb62e:
	cmp_s r0,r16
L_8cb630:
	bl.ne L_8e4694
L_8cb634:
	ld_s r0,[r13,0x18]
L_8cb636:
	cmp_s r0,r16
L_8cb638:
	bl.ne L_8e4694
L_8cb63c:
	st_s r15,[r13,0x14]
L_8cb63e:
	ld_s r0,[r13,0x2c]
L_8cb640:
	ld_s r2,[r0,0xc]
L_8cb642:
	mov_s r0,r13
L_8cb644:
	jl_s.d [r2]
L_8cb646:
	ldb_s r1,[r14,0x4]
L_8cb648:
	bl L_8e4694
L_8cb64c:
	add r1,r13,0x1c
L_8cb650:
	st_s r0,[r13,0x18]
L_8cb652:
	mov_s r0,0x0
L_8cb654:
	bl.d L_8e4840
L_8cb658:
	mov_s r2,r0
L_8cb65a:
	mov_s r0,r13
L_8cb65c:
	bl.d L_8dfb6c
L_8cb660:
	mov r1,-0x1
	.global L_8cb664
L_8cb664:
	b L_8c0324
