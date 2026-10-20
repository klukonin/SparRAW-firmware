/* ut_hw_drivers_cmd_0x135 @ 0x8cc6dc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x135,"ax",@progbits
	.global ut_hw_drivers_cmd_0x135
ut_hw_drivers_cmd_0x135:
	.global L_8cc6dc
L_8cc6dc:
	push_s blink
L_8cc6de:
	bl L_8c02c4
L_8cc6e2:
	cmp_s r0,0x40
L_8cc6e4:
	mov_s r13,r0
L_8cc6e6:
	mov_s r14,r1
L_8cc6e8:
	bge_s L_8cc710
	.global L_8cc6ea
L_8cc6ea:
	mov lp_count,0x3
L_8cc6ee:
	mov_s r1,0x0
L_8cc6f0:
	lp L_8cc70c
L_8cc6f4:
	add2 r2,r1,r13
L_8cc6f8:
	mov_s r0,0x88a208
L_8cc6fe:
	ld.as r0,[r0,r2]
L_8cc702:
	add2 r12,r14,r1
L_8cc706:
	st_s r0,[r12]
L_8cc708:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8cc70a:
	extb_s r1,r1
	.global L_8cc70c
L_8cc70c:
	b L_8c0334
	.global L_8cc710
L_8cc710:
	mov_s r0,blink
L_8cc712:
	mov_s r2,0x1019954
L_8cc718:
	mov_s r1,0x12ce
L_8cc71e:
	bl.d L_8c82c0
L_8cc722:
	mov r3,0x42e
L_8cc726:
	b_s L_8cc6ea
