/* find_mngr__del_discovery_bcon @ 0x8c771c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: >>>>>>>> DEL DMG DISCOVERY BEACOM <<<<<<<<
 * Зовут его: find_main_sm__on_start_listen, find_main_sm__stop, find_main_sm__stop_searching
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, tx_bcon__del_bcon
 */
	.section .text.find_mngr__del_discovery_bcon,"ax",@progbits
	.global find_mngr__del_discovery_bcon
find_mngr__del_discovery_bcon:
	.global L_8c771c
L_8c771c:
	push_s blink
L_8c771e:
	push_s r13
L_8c7720:
	mov_s r13,r0
L_8c7722:
	ld_s r0,[r0,0x68]
L_8c7724:
	breq_s r0,0,L_8c774a
L_8c7726:
	mov_s r2,0x10140cc
L_8c772c:
	mov_s r0,0xc
L_8c772e:
	bl.d L_8edfb0
L_8c7732:
	mov_s r1,0x2
L_8c7734:
	mov_s r0,0x0
L_8c7736:
	st_s r0,[r13,0x68]
L_8c7738:
	bl.d L_8c7578
L_8c773c:
	ld_s r0,[r13,0x6c]
L_8c773e:
	ld_s r1,[r13,0x6c]
L_8c7740:
	add r1,r1,0x14f
L_8c7744:
	ldb_s r0,[r1]
L_8c7746:
	bclr_s r0,r0,0x1
L_8c7748:
	stb_s r0,[r1]
	.global L_8c774a
L_8c774a:
	.byte 0xf5,0x03
