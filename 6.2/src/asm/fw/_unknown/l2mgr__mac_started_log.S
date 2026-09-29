/* l2mgr__mac_started_log @ 0x8f972c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [L2MGR] MAC %d started : ADDR-%04X%08X
 * Зовут его: l2mgr__init, wmi_port_allocate
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3, mac__apply_multicast_addr, mid__open, mid__reset_bss_defaults, mid_list__insert
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__mac_started_log
l2mgr__mac_started_log:
	.global L_8f972c
L_8f972c:
	push_s blink
L_8f972e:
	bl L_8c01d4
L_8f9732:
	mov_s r16,r0
L_8f9734:
	mov_s r13,r1
L_8f9736:
	mov_s r18,r2
L_8f9738:
	bl.d L_8c34d0
L_8f973c:
	mov_s r17,r3
L_8f973e:
	mov.f r14,r0
L_8f9742:
	beq_s L_8f977a
L_8f9744:
	bl.d L_8e68b4
L_8f9748:
	mov_s r1,r13
L_8f974a:
	add3 r0,r14,0x9
L_8f974e:
	mov_s r1,r13
L_8f9750:
	mov_s r2,r18
L_8f9752:
	mov_s r3,r17
L_8f9754:
	mov_s r15,0x1
L_8f9756:
	bl.d L_8c4d24
L_8f975a:
	mov_s r4,r15
L_8f975c:
	bl.d L_8e5f0c
L_8f9760:
	mov_s r0,r14
L_8f9762:
	mov_s r1,0x100e5f8
L_8f9768:
	ld r4,[r13]
L_8f976c:
	mov_s r0,0x2b
L_8f976e:
	mov_s r2,r16
L_8f9770:
	bl.d L_8dcd00
L_8f9774:
	ldw_s r3,[r13,0x4]
L_8f9776:
	mov_s r0,r15
L_8f9778:
	b_s L_8f977c
	.global L_8f977a
L_8f977a:
	mov_s r0,0x0
	.global L_8f977c
L_8f977c:
	b L_8c0234
