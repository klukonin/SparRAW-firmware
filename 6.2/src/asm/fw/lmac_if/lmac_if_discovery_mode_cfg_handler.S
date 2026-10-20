/* lmac_if_discovery_mode_cfg_handler @ 0x8db724, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_discovery_mode_cfg_handler() send command to uCode discovery_mode = %d. m_discovery_type = %d
 * Зовут его: conn_main_sm__action_8c9050, conn_main_sm__action_step, find_mngr__listen_start, find_mngr__search_start, find_mngr__stop, scan_mngr__scan_done, scan_mngr__start_scan
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit2, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_discovery_mode_cfg_handler
lmac_if_discovery_mode_cfg_handler:
	.global L_8db724
L_8db724:
	push_s blink
L_8db726:
	bl L_8c01e0
L_8db72a:
	mov_s r15,r0
L_8db72c:
	mov_s r0,0x804280
L_8db732:
	bl.d L_8c33d0
L_8db736:
	mov_s r13,r1
L_8db738:
	mov.f r14,r0
L_8db73c:
	beq_s L_8db764
L_8db73e:
	mov.f r2,r15
L_8db742:
	mov_s r1,0x10049b8
L_8db748:
	mov.ne r2,0x1
L_8db74c:
	st_s r2,[r14]
L_8db74e:
	st_s r13,[r14,0x4]
L_8db750:
	mov_s r0,0x29
L_8db752:
	bl.d L_8dcc80
L_8db756:
	mov_s r3,r13
L_8db758:
	mov_s r0,r14
L_8db75a:
	mov_s r1,0x24
L_8db75c:
	mov_s r2,0x8
L_8db75e:
	bl.d L_8e5204
L_8db762:
	mov_s r3,0x0
	.global L_8db764
L_8db764:
	b L_8c024c
